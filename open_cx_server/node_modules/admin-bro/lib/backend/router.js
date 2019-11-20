"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var path = _interopRequireWildcard(require("path"));

var _userComponentsBundler = require("./bundler/user-components-bundler");

var _appController = _interopRequireDefault(require("./controllers/app-controller"));

var _apiController = _interopRequireDefault(require("./controllers/api-controller"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

const ASSETS_ROOT = `${__dirname}/../frontend/assets/`;
/**
 * Type representing the AdminBro.Router
 * @memberof AdminBro
 * @alias RouterType
 */

/**
 * Contains list of all routes grouped to `assets` and `routes`.
 *
 * ```
 * {
 *   assets: [{
 *     path: '/frontend/assets/app.min.js',
 *     src: path.join(ASSETS_ROOT, 'scripts/app.min.js'),
 *   }, ...],
 *   routes: [{
 *     method: 'GET',
 *     path: '/resources/{resourceId}',
 *     Controller: ResourcesController,
 *     action: 'index',
 *   }, ...]
 * }
 *
 * ```
 *
 * It is used by supported frameworks to render AdminBro pages.
 *
 * @private
 */
const Router = {
  assets: [{
    path: '/frontend/assets/icomoon.css',
    src: path.join(ASSETS_ROOT, 'styles/icomoon.css')
  }, {
    path: '/frontend/assets/icomoon.eot',
    src: path.join(ASSETS_ROOT, 'fonts/icomoon.eot')
  }, {
    path: '/frontend/assets/icomoon.svg',
    src: path.join(ASSETS_ROOT, 'fonts/icomoon.svg')
  }, {
    path: '/frontend/assets/icomoon.ttf',
    src: path.join(ASSETS_ROOT, 'fonts/icomoon.ttf')
  }, {
    path: '/frontend/assets/icomoon.woff',
    src: path.join(ASSETS_ROOT, 'fonts/icomoon.woff')
  }, {
    path: '/frontend/assets/app.bundle.js',
    src: path.join(ASSETS_ROOT, 'scripts/app-bundle.js')
  }, {
    path: '/frontend/assets/global.bundle.js',
    src: path.join(ASSETS_ROOT, 'scripts/global-bundle.js')
  }, {
    path: '/frontend/assets/logo.svg',
    src: [ASSETS_ROOT, 'images/logo.svg'].join('/')
  }, {
    path: '/frontend/assets/logo-mini.svg',
    src: [ASSETS_ROOT, 'images/logo-mini.svg'].join('/')
  }],
  routes: [{
    method: 'GET',
    path: '',
    Controller: _appController.default,
    action: 'index'
  }, {
    method: 'GET',
    path: '/resources/{resourceId}',
    Controller: _appController.default,
    action: 'resource'
  }, {
    method: 'GET',
    path: '/api/resources/{resourceId}/search/{query}',
    Controller: _apiController.default,
    action: 'search'
  }, {
    method: 'GET',
    path: '/resources/{resourceId}/actions/{action}',
    Controller: _appController.default,
    action: 'resourceAction'
  }, {
    method: 'GET',
    path: '/resources/{resourceId}/records/{recordId}/{action}',
    Controller: _appController.default,
    action: 'recordAction'
  }, {
    method: 'GET',
    path: '/api/resources/{resourceId}/actions/{action}',
    Controller: _apiController.default,
    action: 'resourceAction'
  }, {
    method: 'GET',
    path: '/api/resources/{resourceId}/records/{recordId}/{action}',
    Controller: _apiController.default,
    action: 'recordAction'
  }, {
    method: 'POST',
    path: '/api/resources/{resourceId}/actions/{action}',
    Controller: _apiController.default,
    action: 'resourceAction'
  }, {
    method: 'POST',
    path: '/api/resources/{resourceId}/records/{recordId}/{action}',
    Controller: _apiController.default,
    action: 'recordAction'
  }, {
    method: 'GET',
    path: '/api/resources/{resourceId}/search/',
    Controller: _apiController.default,
    action: 'search'
  }, {
    method: 'GET',
    path: '/api/dashboard',
    Controller: _apiController.default,
    action: 'dashboard'
  }]
};

if (process.env.NODE_ENV === 'production') {
  Router.assets.push({
    path: '/frontend/assets/components.bundle.js',
    src: _userComponentsBundler.outPath
  });
} else {
  Router.routes.push({
    method: 'GET',
    path: '/frontend/assets/components.bundle.js',
    Controller: _appController.default,
    action: 'bundleComponents',
    contentType: 'text/javascript;charset=utf-8'
  });
}

var _default = Router;
exports.default = _default;