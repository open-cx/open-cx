"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRouterDom = require("react-router-dom");

var _styledLink = _interopRequireDefault(require("../ui/styled-link"));

var _apiClient = _interopRequireDefault(require("../../utils/api-client"));

var _viewHelpers = _interopRequireDefault(require("../../../backend/utils/view-helpers"));

var _withNotice = _interopRequireDefault(require("../../store/with-notice"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/* eslint-disable no-undef */

/* eslint-disable no-alert */

/* eslint-disable no-restricted-globals */

/**
 * Renders Button for an action
 *
 * @private
 * @component
 */
class ActionButton extends _react.default.PureComponent {
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(event) {
    const {
      action,
      resourceId,
      recordId,
      location,
      history,
      actionPerformed,
      addNotice
    } = this.props;

    if (action.guard && !confirm(action.guard)) {
      event.preventDefault();
      return;
    }

    if (typeof action.component !== 'undefined' && action.component === false) {
      event.preventDefault();
      const api = new _apiClient.default();
      let apiAction;

      if (recordId) {
        apiAction = api.recordAction;
      } else {
        apiAction = api.resourceAction;
      }

      apiAction.bind(api)({
        resourceId,
        actionName: action.name,
        recordId
      }).then(response => {
        addNotice({
          message: `action ${action.name} has been successfully performed`
        });

        if (location.pathname !== response.data.redirectUrl) {
          history.push(response.data.redirectUrl);
        }

        if (actionPerformed) {
          actionPerformed(action.name);
        }
      });
    }
  }

  render() {
    const h = new _viewHelpers.default();
    const {
      resourceId,
      recordId,
      action,
      className
    } = this.props;
    const actionName = action.name;
    const href = recordId ? h.recordActionUrl({
      resourceId,
      recordId,
      actionName
    }) : h.resourceActionUrl({
      resourceId,
      actionName
    });
    return _react.default.createElement(_styledLink.default, {
      to: href,
      className: `button ${className}`,
      onClick: this.handleClick
    }, _react.default.createElement("span", {
      className: "icon"
    }, _react.default.createElement("i", {
      className: action.icon
    })), _react.default.createElement("div", {
      className: "btn-text"
    }, action.label));
  }

}

// TODO - remove this hack
var _default = (0, _reactRouterDom.withRouter)((0, _withNotice.default)(ActionButton));

exports.default = _default;