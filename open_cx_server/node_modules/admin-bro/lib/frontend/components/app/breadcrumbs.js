"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRouterDom = require("react-router-dom");

var _styledComponents = _interopRequireDefault(require("styled-components"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const BreadcrumbsContainer = _styledComponents.default.nav.attrs({
  className: 'breadcrumb'
}).withConfig({
  displayName: "breadcrumbs__BreadcrumbsContainer",
  componentId: "yjyesi-0"
})(["&&&{margin:", ";font-size:", ";}"], ({
  theme
}) => `-${theme.sizes.padding} 0 ${theme.sizes.padding} -10px`, ({
  theme
}) => theme.fonts.base);

const BreadcrumbLink = (0, _styledComponents.default)(_reactRouterDom.Link).withConfig({
  displayName: "breadcrumbs__BreadcrumbLink",
  componentId: "yjyesi-1"
})(["&&&{color:", ";&:hover{color:", ";}}"], ({
  theme
}) => theme.colors.lightText, ({
  theme
}) => theme.colors.primary);
/**
 * @memberof Breadcrumbs
 */

/**
 * @component
 * @private
 */
class Breadcrumbs extends _react.default.PureComponent {
  renderResource() {
    const {
      resource,
      record
    } = this.props;
    return _react.default.createElement("li", null, _react.default.createElement(BreadcrumbLink, {
      to: resource.href,
      className: record ? 'is-active' : ''
    }, resource.name));
  }

  renderAction() {
    const {
      actionName,
      resource,
      record
    } = this.props;
    const action = resource.resourceActions.find(a => a.name === actionName) || record && record.recordActions.find(a => a.name === actionName);

    if (action) {
      return _react.default.createElement("li", {
        className: "is-active"
      }, _react.default.createElement(BreadcrumbLink, {
        to: "#"
      }, action.label));
    }

    return null;
  }

  render() {
    return _react.default.createElement(BreadcrumbsContainer, null, _react.default.createElement("ul", null, this.renderResource(), this.renderAction()));
  }

}

var _default = Breadcrumbs;
exports.default = _default;