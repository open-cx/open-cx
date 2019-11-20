"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRouterDom = require("react-router-dom");

var _styledComponents = require("styled-components");

var _combineStyles = _interopRequireDefault(require("../../styles/combine-styles"));

var _types = require("../../types");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const theme = (0, _combineStyles.default)();

const TestContextProvider = props => {
  const {
    children
  } = props;
  return _react.default.createElement(_styledComponents.ThemeProvider, {
    theme: theme
  }, _react.default.createElement(_reactRouterDom.StaticRouter, {
    location: "/"
  }, children));
};

TestContextProvider.propTypes = {
  children: _types.childrenType.isRequired
};
var _default = TestContextProvider;
exports.default = _default;