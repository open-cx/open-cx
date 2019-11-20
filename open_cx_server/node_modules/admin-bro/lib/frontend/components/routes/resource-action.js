"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireWildcard(require("react"));

var _reactRedux = require("react-redux");

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _breadcrumbs = _interopRequireDefault(require("../app/breadcrumbs"));

var _actionHeader = _interopRequireDefault(require("../app/action-header"));

var _wrapperBox = _interopRequireDefault(require("../ui/wrapper-box"));

var _notice = _interopRequireDefault(require("../app/notice"));

var _baseActionComponent = _interopRequireDefault(require("../app/base-action-component"));

var _filter = _interopRequireDefault(require("../app/filter"));

var _queryHasFilter = _interopRequireDefault(require("../../utils/query-has-filter"));

var _error = require("../ui/error404");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

const NoticeWrapper = _styledComponents.default.div.withConfig({
  displayName: "resource-action__NoticeWrapper",
  componentId: "sc-1vmuasm-0"
})(["width:100%;position:relative;"]);

const ResourceAction = props => {
  const {
    resources,
    match,
    location
  } = props;
  const {
    resourceId,
    actionName
  } = match.params;
  const resource = resources.find(r => r.id === resourceId);

  if (!resource) {
    return _react.default.createElement(_error.NoResourceError, {
      resourceId: resourceId
    });
  }

  const action = resource.resourceActions.find(r => r.name === actionName);

  if (!action) {
    return _react.default.createElement(_error.NoActionError, {
      resourceId: resourceId,
      actionName: actionName
    });
  }

  const [filterVisible, setFilerVisible] = (0, _react.useState)((0, _queryHasFilter.default)(location.search));
  const [tag, setTag] = (0, _react.useState)('');
  return _react.default.createElement("div", null, _react.default.createElement(NoticeWrapper, null, _react.default.createElement(_notice.default, null)), _react.default.createElement(_wrapperBox.default, null, _react.default.createElement(_breadcrumbs.default, {
    resource: resource,
    actionName: actionName
  }), _react.default.createElement(_actionHeader.default, {
    resource: resource,
    action: action,
    tag: tag,
    toggleFilter: action.showFilter ? () => setFilerVisible(!filterVisible) : undefined
  }), _react.default.createElement(_baseActionComponent.default, {
    action: action,
    resource: resource,
    setTag: setTag
  })), action.showFilter ? _react.default.createElement(_filter.default, {
    resource: resource,
    isVisible: filterVisible,
    toggleFilter: () => {
      setFilerVisible(!filterVisible);
    }
  }) : '');
};

const mapStateToProps = state => ({
  paths: state.paths,
  resources: state.resources
});

var _default = (0, _reactRedux.connect)(mapStateToProps)(ResourceAction);

exports.default = _default;