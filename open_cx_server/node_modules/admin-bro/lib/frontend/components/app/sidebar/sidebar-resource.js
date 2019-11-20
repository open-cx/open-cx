"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRouterDom = require("react-router-dom");

var _styledComponents = _interopRequireDefault(require("styled-components"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const ResourceLink = (0, _styledComponents.default)(_reactRouterDom.NavLink).withConfig({
  displayName: "sidebar-resource__ResourceLink",
  componentId: "umiuds-0"
})(["color:", ";padding:", ";display:block;&:hover{color:", ";}&.active{color:", ";}"], ({
  theme
}) => theme.colors.lightText, ({
  theme
}) => theme.sizes.paddingMin, ({
  theme
}) => theme.colors.primary, ({
  theme
}) => theme.colors.primary);

class SidebarResource extends _react.default.PureComponent {
  render() {
    const {
      resource
    } = this.props;
    return _react.default.createElement("li", null, _react.default.createElement(ResourceLink, {
      to: resource.href
    }, resource.name));
  }

}

var _default = (0, _reactRouterDom.withRouter)(SidebarResource);

exports.default = _default;