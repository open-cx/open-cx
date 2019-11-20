"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRouterDom = require("react-router-dom");

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _viewHelpers = _interopRequireDefault(require("../../../../backend/utils/view-helpers"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const BrandingBox = _styledComponents.default.div.withConfig({
  displayName: "sidebar-branding__BrandingBox",
  componentId: "sc-1ozeetj-0"
})(["margin-bottom:40px;"]);

const LogoLink = (0, _styledComponents.default)(_reactRouterDom.Link).withConfig({
  displayName: "sidebar-branding__LogoLink",
  componentId: "sc-1ozeetj-1"
})(["display:flex;align-items:center;color:", ";font-weight:bold;span{font-size:20px;}"], ({
  theme
}) => theme.colors.defaultText);

const LogoImage = _styledComponents.default.img.withConfig({
  displayName: "sidebar-branding__LogoImage",
  componentId: "sc-1ozeetj-2"
})(["margin-right:", ";height:35px;"], ({
  theme
}) => theme.sizes.padding);

const SidebarBranding = props => {
  const {
    branding
  } = props;
  const {
    logo,
    companyName
  } = branding;
  const h = new _viewHelpers.default();
  return _react.default.createElement(BrandingBox, null, _react.default.createElement(LogoLink, {
    to: h.dashboardUrl()
  }, _react.default.createElement(LogoImage, {
    src: logo,
    alt: companyName,
    height: "35px",
    width: "35px"
  }), _react.default.createElement("span", null, companyName)));
};

var _default = SidebarBranding;
exports.default = _default;