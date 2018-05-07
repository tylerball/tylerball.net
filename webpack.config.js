const path = require('path');
const webpack = require('webpack');
const ManifestPlugin = require('webpack-manifest-plugin');
const cssExtract = require("mini-css-extract-plugin");

const outputPath = path.join(__dirname, '.tmp/dist');

module.exports = {
  entry: {
    site: [
      './source/javascripts/site.js',
      './source/stylesheets/all.scss',
    ],
  },

  output: {
    path: outputPath,
    filename: '[name].[hash].js',
    publicPath: '/'
  },

  module: {
    rules: [
      {
        test: /source\/javascripts\/.*\.js$/,
        exclude: /node_modules|\.tmp|vendor/,
        loader: 'babel-loader',
        query: {
          presets: [
            'es2015',
            'es2016',
          ]
        },
      },
      {
        test: /.*\.scss$/,
        use: [
          cssExtract.loader,
          'css-loader',
          'sass-loader',
        ]
      },
    ],
  },

  plugins: [
    new cssExtract({
      filename: "[name].[hash].css"
    }),
    new ManifestPlugin({
      fileName: 'manifest.json'
    }),
  ]
};
