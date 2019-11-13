import ClassicEditorBase from '@ckeditor/ckeditor5-editor-classic/src/classiceditor';
import ClassicEditorUIView from '@ckeditor/ckeditor5-editor-classic/src/classiceditoruiview';
import EssentialsPlugin from '@ckeditor/ckeditor5-essentials/src/essentials';
//import UploadAdapterPlugin from '@ckeditor/ckeditor5-adapter-ckfinder/src/uploadadapter';
import AutoformatPlugin from '@ckeditor/ckeditor5-autoformat/src/autoformat';
import BoldPlugin from '@ckeditor/ckeditor5-basic-styles/src/bold';
import ItalicPlugin from '@ckeditor/ckeditor5-basic-styles/src/italic';
import UnderlinePlugin from '@ckeditor/ckeditor5-basic-styles/src/underline';
import StrikethroughPlugin from '@ckeditor/ckeditor5-basic-styles/src/strikethrough';
import SubscriptPlugin from '@ckeditor/ckeditor5-basic-styles/src/subscript';
import SuperscriptPlugin from '@ckeditor/ckeditor5-basic-styles/src/superscript';
import ClipboardPlugin from '@ckeditor/ckeditor5-clipboard/src/clipboard';
import BlockQuotePlugin from '@ckeditor/ckeditor5-block-quote/src/blockquote';
//import EasyImagePlugin from '@ckeditor/ckeditor5-easy-image/src/easyimage';
import HeadingPlugin from '@ckeditor/ckeditor5-heading/src/heading';
import ImagePlugin from '@ckeditor/ckeditor5-image/src/image';
import ImageCaptionPlugin from '@ckeditor/ckeditor5-image/src/imagecaption';
import ImageStylePlugin from '@ckeditor/ckeditor5-image/src/imagestyle';
import ImageToolbarPlugin from '@ckeditor/ckeditor5-image/src/imagetoolbar';
//import ImageUploadPlugin from '@ckeditor/ckeditor5-image/src/imageupload';
import LinkPlugin from '@ckeditor/ckeditor5-link/src/link';
import ListPlugin from '@ckeditor/ckeditor5-list/src/list';
import ParagraphPlugin from '@ckeditor/ckeditor5-paragraph/src/paragraph';
import AlignmentPlugin from '@ckeditor/ckeditor5-alignment/src/alignment';
import Base64UploadAdapter from '@ckeditor/ckeditor5-upload/src/adapters/base64uploadadapter';
import ImageResizePlugin from '@ckeditor/ckeditor5-image/src/imageresize';
import TablePlugin from '@ckeditor/ckeditor5-table/src/table';
import TableToolbarPlugin from '@ckeditor/ckeditor5-table/src/tabletoolbar';
import FontPlugin from '@ckeditor/ckeditor5-font/src/font';
import RemoveFormatPlugin from '@ckeditor/ckeditor5-remove-format/src/removeformat';
import BalloonPanelViewPlugin from '@ckeditor/ckeditor5-ui/src/panel/balloon/balloonpanelview';
import ContextualBalloon from '@ckeditor/ckeditor5-ui/src/panel/balloon/contextualballoon';
import LetterCasePlugin from 'ckeditor5-letter-case';

export default class MyClassicEditor extends ClassicEditorBase {}

MyClassicEditor.builtinPlugins = [
    EssentialsPlugin
   // ,UploadAdapterPlugin
    ,BoldPlugin
    ,ItalicPlugin
    ,UnderlinePlugin
    ,StrikethroughPlugin
    ,SubscriptPlugin
    ,SuperscriptPlugin
    ,ClipboardPlugin
    ,BlockQuotePlugin
   // ,EasyImagePlugin
    ,HeadingPlugin
    ,ImagePlugin
    ,ImageCaptionPlugin
    ,ImageStylePlugin
    ,ImageResizePlugin
    ,ImageToolbarPlugin
   // ,ImageUploadPlugin
    ,LinkPlugin
    ,ListPlugin
    ,ParagraphPlugin
    ,AlignmentPlugin
    ,Base64UploadAdapter
    ,RemoveFormatPlugin
    ,TablePlugin
    ,FontPlugin
    ,TableToolbarPlugin
    ,BalloonPanelViewPlugin
    ,ContextualBalloon
    ,LetterCasePlugin
];

MyClassicEditor.defaultConfig = {
    toolbar: {
        items: [
            'heading',
            '|',
            'bold',
            'italic',
            'underline',
            'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor',
            'strikethrough',
            'lettercase',
            'link',
            'bulletedList',
            'numberedList',
            'alignment',
            'subscript',
            'superscript',
            'insertTable',
           // 'imageUpload',
           // 'easyimage',
            'blockQuote',
            'undo',
            'redo',
            'removeformat'
        ]
    },
       image: {
            // You need to configure the image toolbar, too, so it uses the new style buttons.
//            toolbar: [ 'imageTextAlternative', '|', 'imageStyle:alignLeft', 'imageStyle:full', 'imageStyle:alignRight' ],
            toolbar: [ 'imageStyle:alignLeft', 'imageStyle:full', 'imageStyle:alignRight' ],

            styles: [
                // This option is equal to a situation where no style is applied.
                'full',

                // This represents an image aligned to the left.
                'alignLeft',

                // This represents an image aligned to the right.
                'alignRight'
            ]
        },
        table: {
            contentToolbar: [ 'tableColumn', 'tableRow', 'mergeTableCells' ]
        },
        fontFamily: {
            options: [
                'default',
                'Ubuntu, Arial, sans-serif',
                'Ubuntu Mono, Courier New, Courier, monospace',
                'Arial, Helvetica, sans-serif',
                'Courier New, Courier, monospace',
                'Georgia, serif',
                'Lucida Sans Unicode, Lucida Grande, sans-serif',
                'Tahoma, Geneva, sans-serif',
                'Times New Roman, Times, serif',
                'Trebuchet MS, Helvetica, sans-serif',
                'Verdana, Geneva, sans-serif'

            ]
        },



    language: 'en'
};

/*
MyClassicEditor
    // Note that you do not have to specify the plugin and toolbar configuration — using defaults from the build.
    .create( document.querySelector( '.editor' ) )
    .then( editor => {
        console.log( 'Editor was initialized', editor );
    } )
    .catch( error => {
        console.error( "Hit the MyClassicEditor Catch Error", error );
        console.error( error.stack );
    } );

MyClassicEditor
    .create( document.querySelector( '#editor' ), {
//        plugins: [ Essentials, Paragraph, Bold, Italic, Underline,Subscript,Superscript,Strikethrough],
//       toolbar: [ 'bold', 'italic','underline','subscript','superscript','strikethrough' ]
    } )
    .then( editor => {
        console.log( 'Editor was initialized', editor );
        console.log (Array.from( editor.ui.componentFactory.names() ) );
    } )
    .catch( error => {
        console.error( error );
        console.error( error.stack );
    } );
*/
