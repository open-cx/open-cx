"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRedux = require("react-redux");

var _reactRouterDom = require("react-router-dom");

var _styledComponents = require("styled-components");

var _application = _interopRequireDefault(require("./components/app/application"));

var _propertyType = _interopRequireDefault(require("./components/property-type"));

var _store = _interopRequireDefault(require("./store/store"));

var _viewHelpers = _interopRequireDefault(require("../backend/utils/view-helpers"));

var Components = _interopRequireWildcard(require("./components/ui"));

var AppComponents = _interopRequireWildcard(require("./components/app"));

var _apiClient = _interopRequireDefault(require("./utils/api-client"));

var style = _interopRequireWildcard(require("./styles/variables"));

var types = _interopRequireWildcard(require("./types"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const env = {
  NODE_ENV: process.env.NODE_ENV || 'development'
};
const store = (0, _store.default)(window.REDUX_STATE);
const theme = window.THEME;

const Application = _react.default.createElement(_reactRedux.Provider, {
  store: store
}, _react.default.createElement(_styledComponents.ThemeProvider, {
  theme: theme
}, _react.default.createElement(_reactRouterDom.BrowserRouter, null, _react.default.createElement(_application.default, null)))); // eslint-disable-next-line no-undef


window.regeneratorRuntime = regeneratorRuntime;
var _default = {
  Application,
  ViewHelpers: _viewHelpers.default,
  UserComponents: {},
  ApiClient: _apiClient.default,
  style,
  PropertyTypes: _propertyType.default,
  env,
  ...Components,
  ...AppComponents,
  types,
  // TODO: following is a backward compatible - remove this in version 2.0
  Components: { ...Components,
    ...AppComponents
  }
};
exports.default = _default;