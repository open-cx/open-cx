"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const StyledHamburger = _styledComponents.default.a.withConfig({
  displayName: "hamburger__StyledHamburger",
  componentId: "o1hcva-0"
})(["cursor:pointer;display:block;float:left;width:48px;height:32px;padding:10px ", ";position:relative;z-index:10;& > div{width:100%;height:2px;background-color:", ";margin-bottom:3px;}"], ({
  theme
}) => theme.sizes.padding, ({
  theme
}) => theme.colors.defaultText);

const Hamburger = props => _react.default.createElement(StyledHamburger, props, _react.default.createElement("div", null), _react.default.createElement("div", null), _react.default.createElement("div", null));

var _default = Hamburger;
exports.default = _default;