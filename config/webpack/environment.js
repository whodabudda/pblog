const path = require( 'path' );
const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const erb = require('./loaders/erb')
const WebpackAssetsManifest = require('webpack-assets-manifest');
environment.loaders.prepend('erb', erb)
// resolve-url-loader must be used before sass-loader
environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader',
});

environment.config.merge({
  module: {
    rules: [
      {
        test: require.resolve('jquery'),
        use: [{
          loader: 'expose-loader',
          options: '$'
        }, {
          loader: 'expose-loader',
          options: 'jQuery'
        }]
      }
      /*
      ,
      {
        test: path.resolve('./pblog/user_options_form'),
        use: [{
          loader: 'expose-loader',
          options: 'checkBrowserSupport'
        }]
      }
      */
      /*
      ,
      {
        test: require.resolve( './ckeditor/myck_classic_editor'),
        use: [{
          loader: 'expose-loader',
          options: 'MyClassicEditor'
        }]
      }
		*/
    ]
  }
});
/*
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default'],
}));
*/

//ppk added for ckeditor

const CKEditorWebpackPlugin = require( '@ckeditor/ckeditor5-dev-webpack-plugin' )
environment.plugins.prepend('CKEditor',new CKEditorWebpackPlugin({
  language: 'en'
  })
)
//will get module build error if regular css loader used with ck
const cssLoader = environment.loaders.get('css');
cssLoader.exclude = /(\.module\.[a-z]+$)|(ckeditor5-[^/\\]+[/\\]theme.?[/\\].+\.css)/
//add the ckeditor loaders to webpackers list of loaders
const ckeditorCSS = require('./loaders/ckeditor-css')
environment.loaders.append('ckeditorCSS', ckeditorCSS)
//ckeditor also needs to load svg's in its own special way
const fileLoader = environment.loaders.get('file');
fileLoader.exclude = /(\.module\.[a-z]+$)|(ckeditor5-[^/\\]+[/\\]theme.?[/\\].+\.svg)/
environment.loaders.insert('svg', {
  test: /(\.module\.[a-z]+$)|(ckeditor5-[^/\\]+[/\\]theme.?[/\\].+\.svg)/,
  use: 'raw-loader'
}, { after: 'file' })

// end of ppk add ckeditor


environment.splitChunks()
//svgRule.uses.clear();  // probably needed if using Vue
// end of ppk add ckeditor

module.exports = environment

