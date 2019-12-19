"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _sidebarResource = _interopRequireDefault(require("./sidebar-resource"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const Title = _styledComponents.default.span.withConfig({
  displayName: "sidebar-parent__Title",
  componentId: "sc-1f3abux-0"
})(["background:", ";padding-left:", ";padding-right:", ";line-height:40px;border-radius:", ";display:flex;align-items:baseline;color:", ";position:relative;& > i,& > svg{margin-right:", ";color:", ";margin-right:", ";}"], ({
  theme
}) => theme.colors.lightBck, ({
  theme
}) => theme.sizes.padding, ({
  theme
}) => theme.sizes.padding, ({
  theme
}) => theme.sizes.paddingLayout, ({
  theme
}) => theme.colors.defaultText, ({
  theme
}) => theme.sizes.paddingMin, ({
  theme
}) => theme.colors.lightText, ({
  theme
}) => theme.sizes.padding);

const ResourcesList = _styledComponents.default.ul.withConfig({
  displayName: "sidebar-parent__ResourcesList",
  componentId: "sc-1f3abux-1"
})(["margin:", " 0;padding-left:40px;"], ({
  theme
}) => theme.sizes.padding);

class SidebarParent extends _react.default.PureComponent {
  render() {
    const {
      parent
    } = this.props;
    const {
      icon,
      name,
      resources
    } = parent;
    return _react.default.createElement("li", null, _react.default.createElement(Title, null, _react.default.createElement("i", {
      className: icon
    }), name), _react.default.createElement(ResourcesList, null, resources.map(resource => _react.default.createElement(_sidebarResource.default, {
      resource: resource,
      key: resource.id
    }))));
  }

}

var _default = SidebarParent;
exports.default = _default;