/*
 * This is a JavaScript Scratchpad.
 *
 * Enter some JavaScript, then Right Click or choose from the Execute Menu:
 * 1. Run to evaluate the selected text (Ctrl+R),
 * 2. Inspect to bring up an Object Inspector on the result (Ctrl+I), or,
 * 3. Display to insert the result in a comment after the selection. (Ctrl+L)
 */
var sub = '{"endpoint":"https://updates.push.services.mozilla.com/wpush/v2/gAAAAABdDYwRN0v34oWtNh3_QMCWXxyQ9sKh7wScqvgKeCNuhfT6TNiD3MurwmATz22eB8-RryzW2TS5bMzTW1rv1vrOHT8QozyYuyHAR9Gn4zRh7hNCYh0Yz8TAtxY5aQGNJAxmnEiA5BESm3qviVCgyecOqVA8WlFczOc9MM-AQpEV2Heuuzs","keys":{"auth":"ooBDC3eVp-oh1sWBe7jPeg","p256dh":"BJR9Ts2AHzTkVoF4sx2mvvSGACRqMJ7pYXN0Xq7CkwEZx5vm2QU7s_qSkc_mAj0ucDFw_dGZzQAJkKORAKTl6Mc"}}'
var ssub = JSON.stringify(sub)
var psub = JSON.parse(sub)
var pssub = JSON.parse(ssub)
console.log("sub  ",sub)
console.log("ssub  ",ssub)
console.log("psub  ",psub)
console.log("pssub  ", pssub)
//console.log(sub.keys.auth)
//console.log(ssub.keys.auth)
console.log("psub auth key  ",psub.keys.auth)
//console.log(pssub.keys.auth)

/*
Exception: TypeError: pssub.keys is undefined
@Scratchpad/3:12:1
*/
