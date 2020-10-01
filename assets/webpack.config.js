const path = require('path');
const glob = require('glob');
const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = (env, options) => ({
	optimization: {
		minimizer: [
			new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
			new OptimizeCSSAssetsPlugin({})
		]
	},
	entry: {
		app: ['./js/app.js'].concat(glob.sync('./vendor/**/*.js')),
		starter_controller: ['./js/controllers/starter_controller.js'],
		analytics_controller: ['./js/controllers/analytics_controller.js'],
		email_controller: ['./js/controllers/email_controller.js'],
		images_controller: ['./js/controllers/images_controller.js'],
		gallery_controller: ['./js/controllers/gallery_controller.js'],
		notes_controller: ['./js/controllers/notes_controller.js'],
		note_controller: ['./js/controllers/note_controller.js'],
		roster_controller: ['./js/controllers/roster_controller.js'],
    apprentice_controller: ['./js/controllers/apprentice_controller.js'],
    tasks_controller: ['./js/controllers/tasks_controller.js'],
    management_controller: ['./js/controllers/management_controller.js'],
    deliverable_controller: ['./js/controllers/deliverable_controller.js'],
    course_creation_controller: ['./js/controllers/course_creation_controller.js'],
    course_session_controller: ['./js/controllers/course_session_controller.js']
	},
	output: {
		filename: '[name].js',
		path: path.resolve(__dirname, '../priv/static/js')
	},
	module: {
		rules: [
			{
				test: /\.js$/,
				exclude: /node_modules/,
				use: {
					loader: 'babel-loader'
				}
			},
			{
				test: /\.css$/,
				use: [MiniCssExtractPlugin.loader, 'css-loader']
			},
			{
				test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
				use: [{
					loader: 'file-loader',
					options: {
						name: '[name].[ext]',
						outputPath: '../fonts'
					}
				}]
			}
		]
	},
	resolve: {
		alias: {
			'vue$': 'vue/dist/vue.esm.js'
		}
	},
	plugins: [
		new MiniCssExtractPlugin({ filename: '../css/[name].css' }),
		new CopyWebpackPlugin([{ from: 'static/', to: '../' }])
	]
});
