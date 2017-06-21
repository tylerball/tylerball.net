const path = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const ManifestPlugin = require('webpack-manifest-plugin');

const outputPath = path.join(__dirname, '.tmp/dist');

module.exports = {
  entry: {
    site: [
      './source/javascripts/site.js',
      './source/stylesheets/all.scss',
    ],
  },

  resolve: {
    root: __dirname + '/source/javascripts',
  },

  output: {
    path: outputPath,
    filename: '[name].[hash].js',
    publicPath: '/'
  },

  module: {
    loaders: [
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
        loader: ExtractTextPlugin.extract(
          "css!sass?sourceMap&includePaths[]=" + __dirname + "/node_modules"
        )
      },
    ],
  },

  plugins: [
    new ExtractTextPlugin("[name].[hash].css"),
    new ManifestPlugin({
      fileName: 'manifest.json'
    }),
  ]
};
