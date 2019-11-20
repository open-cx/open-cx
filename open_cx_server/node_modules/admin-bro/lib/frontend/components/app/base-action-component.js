"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _wrapperBox = _interopRequireDefault(require("../ui/wrapper-box"));

var _errorBoundary = _interopRequireDefault(require("./error-boundary"));

var actions = _interopRequireWildcard(require("../actions"));

var _constants = require("../../../constants");

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/**
 * Component which renders all the default and custom actions for both the Resource and the Record.
 *
 * It passes all props down to the actual Action component.
 *
 * Example of creating your own actions:
 * ```
 * // AdminBro options
 * const AdminBroOptions = {
 *   resources: [
 *      resource,
 *      options: {
 *        actions: {
 *           myNewAction: {
 *             label: 'amazing action',
 *             icon: 'fas fa-eye',
 *             inVisible: (resource, record) => record.param('email') !== '',
 *             actionType: 'record',
 *             component: AdminBro.bundle('./my-new-action'),
 *             handler: (request, response, data) => {
 *               return {
 *                  ...
 *               }
 *             }
 *           }
 *        }
 *      }
 *   ]
 * }
 * ```
 *
 * ```
 * // ./my-new-action.jsx
 * import WrapperBox from 'admin-bro'
 *
 * const MyNewAction = (props) => {
 *   const { resource, action, record } = props
 *   // do something with the props and render action
 *   return (
 *     <WrapperBox>Some Action Content</WrapperBox>
 *   )
 * }
 * ```
 *
 * @component
 * @name BaseActionComponent
 * @category Base
 */
class BaseActionComponent extends _react.default.Component {
  constructor(props) {
    super(props);
    this.state = {
      isClient: false
    };
  }

  componentDidMount() {
    this.setState({
      isClient: true
    });
  }

  render() {
    const {
      resource,
      action,
      record,
      setTag
    } = this.props;
    const {
      isClient
    } = this.state;
    const documentationLink = [_constants.DOCS, 'BaseAction.html'].join('/');
    let Action = actions[action.name];

    if (isClient && action.component) {
      Action = AdminBro.UserComponents[action.component];
    }

    if (Action) {
      return _react.default.createElement(_errorBoundary.default, null, _react.default.createElement(Action, {
        action: action,
        resource: resource,
        record: record,
        setTag: setTag
      }));
    }

    return Action || _react.default.createElement(_wrapperBox.default, {
      border: true
    }, _react.default.createElement("div", {
      className: "notification"
    }, "You have to implement action component for your Action. See:", ' ', _react.default.createElement("a", {
      href: documentationLink
    }, "the documentation")));
  }

}

var _default = BaseActionComponent;
exports.default = _default;