const { styles } = require( '@ckeditor/ckeditor5-dev-utils' );
module.exports = {
        rules: [
            {
                // Or /ckeditor5-[^/]+\/theme\/.+\.css$/ if you want to limit this loader
                // to CKEditor 5 theme only.
                test:  /@ckeditor\/ckeditor5-[^/]+\/theme\/.+\.css$/,
                use: [
                    {
                        loader: 'style-loader',
                        options: {
                            injectType: 'singletonStyleTag'
                        }
                    },
                    {
                        loader: 'postcss-loader',
                        options: styles.getPostCssConfig( {
                            themeImporter: {
                                themePath: require.resolve( '@ckeditor/ckeditor5-theme-lark' )
                            },
                            minify: true
                        } )
                    }
                ]
            }
        ]
    // Useful for debugging.
//   devtool: 'source-map',

    // By default webpack logs warnings if the bundle is bigger than 200kb.
//    performance: { hints: false }
}