"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class ErrorBoundary extends _react.default.Component {
  constructor(props) {
    super(props);
    this.state = {
      error: null
    };
  }

  componentDidCatch(error) {
    this.setState({
      error
    });
  }

  render() {
    const {
      children
    } = this.props;
    const {
      error
    } = this.state;

    if (error !== null) {
      return _react.default.createElement("div", {
        className: "notification is-danger"
      }, _react.default.createElement("p", null, error.toString()), _react.default.createElement("p", null, "See development console for more details..."));
    }

    return children || null;
  }

}

var _default = ErrorBoundary;
exports.default = _default;