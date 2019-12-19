"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _reactRouterDom = require("react-router-dom");

var _actionButton = _interopRequireDefault(require("./action-button"));

var _styledButton = _interopRequireDefault(require("../ui/styled-button"));

var _viewHelpers = _interopRequireDefault(require("../../../backend/utils/view-helpers"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const HeaderWrapper = _styledComponents.default.section.attrs({
  className: 'level'
}).withConfig({
  displayName: "action-header__HeaderWrapper",
  componentId: "sc-17u6jqx-0"
})(["&&&{margin-bottom:", ";}"], ({
  theme
}) => theme.sizes.padding);

const Tag = _styledComponents.default.span.attrs({
  className: 'tag'
}).withConfig({
  displayName: "action-header__Tag",
  componentId: "sc-17u6jqx-1"
})(["&&&{background:", ";color:#fff;margin-left:", ";}"], ({
  theme
}) => theme.colors.primary, ({
  theme
}) => theme.sizes.padding);

const BackBtn = (0, _styledComponents.default)(_reactRouterDom.Link).withConfig({
  displayName: "action-header__BackBtn",
  componentId: "sc-17u6jqx-2"
})(["&&&{border-radius:50%;width:", ";height:", ";color:", ";font-size:", ";padding:", ";background-color:", ";text-align:center;margin-right:", ";&:hover{background-color:", ";color:#fff;}}"], ({
  theme
}) => theme.sizes.paddingLayout, ({
  theme
}) => theme.sizes.paddingLayout, ({
  theme
}) => theme.colors.lightText, ({
  theme
}) => theme.fonts.base, ({
  theme
}) => theme.sizes.paddingMin, ({
  theme
}) => theme.colors.superLightBack, ({
  theme
}) => theme.sizes.padding, ({
  theme
}) => theme.colors.lightText);

const HeaderTitle = _styledComponents.default.h1.attrs({
  className: 'level-left'
}).withConfig({
  displayName: "action-header__HeaderTitle",
  componentId: "sc-17u6jqx-3"
})(["&&&{font-size:", ";font-weight:normal;}"], ({
  theme
}) => theme.fonts.header);

const HeaderButtons = _styledComponents.default.div.attrs({
  className: 'level-right'
}).withConfig({
  displayName: "action-header__HeaderButtons",
  componentId: "sc-17u6jqx-4"
})(["&&& a{margin-left:", ";}"], ({
  theme
}) => theme.sizes.padding);
/**
 * @memberof ActionHeader
 * @private
 */


/**
 * Header of an action
 *
 * @private
 * @component
 */
const ActionHeader = props => {
  const h = new _viewHelpers.default();
  const {
    resource,
    toggleFilter,
    actionPerformed,
    record,
    action,
    tag,
    recordId
  } = props;
  const resourceId = resource.id;
  let actions = record ? record.recordActions : resource.resourceActions; // list action is not accessible via the ActionHeader buttons

  actions = actions && actions.filter(ra => ![action && action.name, 'list'].includes(ra.name));
  const title = action ? action.label : resource.name;
  const isList = action && action.name === 'list';
  return _react.default.createElement(HeaderWrapper, null, _react.default.createElement(HeaderTitle, null, !isList && _react.default.createElement(BackBtn, {
    to: h.resourceActionUrl({
      resourceId,
      actionName: 'list'
    })
  }, _react.default.createElement("i", {
    className: "icomoon-pagination-left"
  })), title, tag ? _react.default.createElement(Tag, null, tag) : ''), _react.default.createElement(HeaderButtons, null, actions.map(headerAction => _react.default.createElement(_actionButton.default, {
    action: headerAction,
    key: headerAction.name,
    actionPerformed: actionPerformed,
    className: "is-primary",
    resourceId: resource.id,
    recordId: recordId
  })), toggleFilter && _react.default.createElement(_styledButton.default, {
    onClick: toggleFilter,
    as: "a"
  }, _react.default.createElement("span", {
    className: "icon"
  }, _react.default.createElement("i", {
    className: "fas fa-sliders-h"
  })), _react.default.createElement("span", {
    className: "btn-text"
  }, "Filter"))));
};

var _default = ActionHeader;
exports.default = _default;