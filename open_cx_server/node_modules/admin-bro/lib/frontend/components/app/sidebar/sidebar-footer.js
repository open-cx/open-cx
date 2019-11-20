"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const StyledFooter = _styledComponents.default.p.withConfig({
  displayName: "sidebar-footer__StyledFooter",
  componentId: "sc-1n82yn-0"
})(["font-size:", ";text-align:center;color:", ";& svg,& a{color:", ";margin:0  ", ";}"], ({
  theme
}) => theme.fonts.min, ({
  theme
}) => theme.colors.lightText, ({
  theme
}) => theme.colors.love, ({
  theme
}) => theme.sizes.paddingMin);

const SidebarFooter = props => {
  const {
    hidden
  } = props;

  if (hidden) {
    return _react.default.createElement(StyledFooter, null, _react.default.createElement("a", {
      href: "http://softwarebrothers.co",
      target: "_blank",
      rel: "noopener noreferrer"
    }, _react.default.createElement("i", {
      className: "fas fa-heart fa-2x"
    })));
  }

  return _react.default.createElement(StyledFooter, null, _react.default.createElement("span", null, "With", _react.default.createElement("i", {
    className: "fas fa-heart"
  }), "by", _react.default.createElement("a", {
    href: "http://softwarebrothers.co",
    target: "_blank",
    rel: "noopener noreferrer"
  }, "SoftwareBrothers")));
};

var _default = SidebarFooter;
exports.default = _default;