const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

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
    path: __dirname + '/.tmp/dist',
    filename: 'javascripts/[name].js',
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
    new ExtractTextPlugin("[name].css")
  ]
};
