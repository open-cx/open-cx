"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propertyInShow = _interopRequireDefault(require("../../ui/property-in-show"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class Show extends _react.default.PureComponent {
  constructor(props) {
    super(props);
    this.contentRef = _react.default.createRef();
  }

  componentDidMount() {
    const {
      property,
      record
    } = this.props;
    const value = record.params[property.name];
    this.contentRef.current.innerHTML = value;
  }

  render() {
    const {
      property
    } = this.props;
    return _react.default.createElement(_propertyInShow.default, {
      property: property
    }, _react.default.createElement("div", {
      className: "rich-text-value content",
      ref: this.contentRef
    }));
  }

}

exports.default = Show;