// function checkBrowserSubscription () {
//  navigator.serviceWorker.ready
//   .then( function(swReg) {
//     swReg.pushManager.getSubscription()
//     .then(function(subscription) {
//         console.log('[checkBrowserSubscription returned]:', (subscription ? subscription.endpoint : null) );
//         return subscription;
//      }).catch(function(err) {
//      	console.log("checkBrowserSubscription threw an Error!",err);
//      	var err_msg = (err.message ? err.message : "unknown error");
// 	    $('.subscription_message').text('The Browser Service returned error:' + err_msg).addClass('notifications-problem');
// 	    throw err;
//      })
//   })

// };a

const isNNNU = (value) => typeof value !== "undefined" && (typeof value !== "object" || !value)
function getRegistration(swname,swscope){
	console.log('[getRegistration] args ', arguments[0],' ', arguments[1])
	console.log('[getRegistration] argnames ', swname, ' ',swscope)
  return navigator.serviceWorker.register(swname, { scope: swscope })
  .then(function(registration) {
	if(! registration) {
		reject ( new Error ("failed to register"));
	}
  	return registration
   })
	.catch (function (err) {
		 console.log('[getRegistration]:', err );
   })
}

// 

function reconcileSubscriptions (db_subscription, subscription) {
  	//var current_subscription = $('#webpush-subscription').val();
   	//console.log('reconcileSubscriptions: current subscription ', current_subscription);
  	//current_subscription = decodeHtml(current_subscription);
   	//console.log('reconcileSubscriptions: current subscription after decodeHtml ', current_subscription);
   	var dbJSObject; 
   	var regJSObject; 
   	if (subscription == null) {
		  $('.subscription_message').text('No subscription registered with browser').addClass('notifications-problem').removeClass('checkmark');
		  return false
	}
   	if (!isNNNU(db_subscription) || !(db_subscription.length > 100)) {
		$('.subscription_message').text('No previously saved subscription. Please save.').addClass('notifications-problem').removeClass('checkmark');
		document.getElementById("webpush-subscription").value = JSON.stringify(subscription);
	    return false;
   	}
   	try {
		dbJSObject = JSON.parse(db_subscription);
		regJSObject = subscription;
   	}
   	catch(err){
		$('.subscription_message').text('Error parsing stored subscription').addClass('notifications-problem').removeClass('checkmark');
	    console.log("reconcileSubscriptions: unable to parse db subscription", JSON.stringify(dbJSObject));
	    return false;
   	}

	if( dbJSObject.endpoint && regJSObject.endpoint != dbJSObject.endpoint) {
	  $('.subscription_message').text('You have a new subscription. Please save before leaving this page.').addClass('notifications-problem').removeClass('checkmark');
	  document.getElementById("webpush-subscription").value = JSON.stringify(regJSObject);
	  console.log('reconcileSubscriptions: registered subscription endpoint', regJSObject.endpoint);
	  console.log('reconcileSubscriptions: DB subscription endpoint', dbJSObject.endpoint);
	}
	else {
	  $('.subscription_message').text('Currently saved subscription is good').addClass('checkmark').removeClass('notifications-problem');
	}
	return true;
}

function decodeHtml(html) {
    var txt = document.createElement("textarea");
    txt.innerHTML = html;
    return txt.value;
}

//
//if browser supports notifications, function to check permissions
//
function checkNotification () {
// Let's check whether notification permissions have already been granted
let return_val = true;
//alert("im in the checkNotification function");

if (Notification.permission === "granted") {
  console.log("Browser supports notifications and Permission has been granted");
  $('.webpush-checkbox span').text(' Browser setting allows notifications from this site').addClass("checkmark").removeClass('notifications-problem');
}
// Otherwise, we need to ask the user for permission
else if (Notification.permission !== 'denied') {
  Notification.requestPermission(function (permission) {
    // If the user accepts, let's create a notification
    if (permission === "granted") {
      console.log("Permission to receive notifications has been granted");
    }
  	else {
  		$('#webpush-checkbox').prop( "checked", false );
  		$('.webpush-checkbox span').text('Permission for Notifications not granted.').addClass('notifications-problem').removeClass('checkmark');
		return_val = false; 
  	}
  });
}
else {
  	$('#webpush-checkbox').prop( "disabled", true );
  	$('.webpush-checkbox span').text('Permission is denied. You must change this in your browser settings before we can send notifications.').addClass('notifications-problem').removeClass('checkmark');
	return_val = false; 
};	
return return_val; 
};

function setSubscriptionValues (vapidPublic) {
	if (checkNotification()) {
  		var current_db_subscription;
  		current_db_subscription = $('#webpush-subscription').val();
  		var current_reg_subscription;
		getRegisteredSubscription()
		.then(function(subscription){
			current_reg_subscription = subscription;
			console.log('[setSubscriptionValues]current_db_subscription ', JSON.stringify(current_db_subscription));
			console.log('[setSubscriptionValues]current_reg_subscription ', JSON.stringify(current_reg_subscription));
	  		if(!current_reg_subscription) {
	  			current_reg_subscription = getNewSubscription(vapidPublic);
	  		}
	  		//if((current_db_subscription.length > 100) && current_reg_subscription ) {

			reconcileSubscriptions(current_db_subscription,current_reg_subscription);
		})
	}
}
function getRegisteredSubscription() {
   return getRegistration("/sw_push.js","/user_options")
  .then(function(registration) {
	if(!registration) {
		throw new Error ("Failed to register")
	}
 	console.log('[ getRegisteredSubscription ]  Got registration ')
    return registration.pushManager.getSubscription()
   })
  .then (function(subscription){
  	 if (!subscription){
		throw new Error ("no registered subscription")
  	 }
	 console.log('[ getRegisteredSubscription ]  Got subscription ', JSON.stringify(subscription))
  	 return subscription;
   })
  .catch (function(err){
	 console.log('[getRegisteredSubscription]:', err )
	})
}
function getNewSubscription(vapidPublic) {
	return getRegistration("/sw_push.js","/user_options")
  .then(function(registration) {
	if(registration) {
	    const subscribeOptions = {
	      userVisibleOnly: true,
	      applicationServerKey: urlBase64ToUint8Array(vapidPublic) 
	  	};
	    registration.pushManager.subscribe(subscribeOptions)
	    .then(function(subscription) {
		   	if(subscription) {
		   	 console.log('Received NEW subscription: ', JSON.stringify(subscription));
			 $('.subscription_message').text('A new subscription has been obtained from your Browser.  You must save.').addClass('notifications-problem').removeClass('checkmark');
			 document.getElementById("webpush-subscription").value = JSON.stringify(subscription);
		     return subscription;
		    }
		    else {
				reject ( new Error ("failed to find new subscription"));
		    }
	   })
	}
   })
	.catch (function(err) {
		 console.log('[getNewSubscription]:', err );
	})
}
/**
 * urlBase64ToUint8Array
 * 
 * @param {string} base64String a public vavid key
 */
function urlBase64ToUint8Array(base64String) {
    var padding = '='.repeat((4 - base64String.length % 4) % 4);
    var base64 = (base64String + padding)
        .replace(/\-/g, '+')
        .replace(/_/g, '/');

    var rawData = window.atob(base64);
    var outputArray = new Uint8Array(rawData.length);

    for (var i = 0; i < rawData.length; ++i) {
        outputArray[i] = rawData.charCodeAt(i);
    }
    return outputArray;
}
// Let's check if the browser supports notifications
export function checkBrowserSupport(vapidPublic) {
	if (!("Notification" in window)) {
		console.error("This browser does not support desktop notification");
		$('#webpush-checkbox').prop( "disabled", true );
		$('.webpush-checkbox span').text('This browser does not support notifications').addClass('notifications-problem').removeClass('checkmark');
	}
	else {
		if ( $('#webpush-checkbox').prop( "checked"))
		{
			setSubscriptionValues(vapidPublic)
		}
	}
}

//function getBrowserSubscription () {
//   return new Promise( async (resolve,reject) => {
// //  navigator.serviceWorker.getRegistration('/')
// // navigator.serviceWorker.ready
// //.then(function(registration) {

//   swReg = navigator.serviceWorker.register('/sw_push.js', { scope: '/user_options/push' })
//   .then( function(swReg) {
//   	 // if !(swReg) {
//   	 // 	swReg = navigator.serviceWorker.register('/serviceworker.js', { scope: '/' })
//   	 // }
//   	 //swReg.update()
//   	 swReg.pushManager.getSubscription()
//     .then(function(subscription) {
//     	if(subscription) {
// 	        console.log('[getBrowserSubscription Browser returned]:', (subscription ? subscription.endpoint : null) );
//     	    return resolve (subscription);
//     	}

//        subscription = swReg.pushManager.subscribe({
//     	    userVisibleOnly: true
//        });

//        if(subscription) {
//         console.log('[getBrowserSubscription New Subscription endpoint]', subscription.endpoint );
//         return resolve (subscription);
//        };
//        console.log('getBrowserSubscription: subscription is null');
//        reject();

//      }).catch(function(err) {
//      	console.log("getBrowserSubscription threw an Error!",err);
//        	var err_msg = (err.message ? err.message : "unknown error");
// 		$('.subscription_message').text('The Browser Service returned error:' + err_msg).addClass('notifications-problem').removeClass('checkmark');
// 	    throw err;
//      })

//   })
// })
// }