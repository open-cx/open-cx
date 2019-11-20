"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRouterDom = require("react-router-dom");

var _propertyType = _interopRequireDefault(require("../property-type"));

var _wrapperBox = _interopRequireDefault(require("../ui/wrapper-box"));

var _styledButton = _interopRequireDefault(require("../ui/styled-button"));

var _apiClient = _interopRequireDefault(require("../../utils/api-client"));

var _withNotice = _interopRequireDefault(require("../../store/with-notice"));

var _store = require("../../store/store");

var _propertyJson = require("../../../backend/decorators/property-json.interface");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class Edit extends _react.default.Component {
  constructor(props) {
    super(props);
    const {
      record
    } = props;
    this.handleChange = this.handleChange.bind(this);
    this.state = {
      record
    };
    this.api = new _apiClient.default();
  }

  handleChange(propertyOrRecord, value) {
    if (typeof value === 'undefined' && propertyOrRecord.params) {
      this.setState({
        record: propertyOrRecord
      });
    } else {
      this.setState(state => ({
        record: { ...state.record,
          params: { ...state.record.params,
            [propertyOrRecord]: value
          }
        }
      }));
    }
  }

  handleSubmit(event) {
    const {
      resource,
      history,
      addNotice
    } = this.props;
    const {
      record
    } = this.state;
    this.api.recordAction({
      resourceId: resource.id,
      actionName: 'edit',
      recordId: record.id,
      payload: {
        record: record.params
      }
    }).then(response => {
      if (response.data.redirectUrl) {
        history.push(response.data.redirectUrl);
        addNotice({
          message: 'Record has been successfully updated!'
        });
      } else {
        addNotice({
          type: _store.NoticeType.error,
          message: 'There were errors in the record object. Check them out'
        });
        this.setState(state => ({
          record: { ...state.record,
            errors: response.data.record.errors
          }
        }));
      }
    }).catch(() => {
      addNotice({
        message: 'There was an error updating record, Check out console to see more information.',
        type: _store.NoticeType.error
      });
    });
    event.preventDefault();
    return false;
  }

  render() {
    const {
      resource
    } = this.props;
    const properties = resource.editProperties;
    const {
      record
    } = this.state;
    return _react.default.createElement(_wrapperBox.default, {
      border: true
    }, _react.default.createElement("form", {
      onSubmit: this.handleSubmit.bind(this)
    }, properties.map(property => _react.default.createElement(_propertyType.default, {
      key: property.name,
      where: _propertyJson.PropertyPlace.edit,
      onChange: this.handleChange,
      property: property,
      resource: resource,
      record: record
    })), _react.default.createElement(_styledButton.default, {
      type: "submit",
      className: "is-primary"
    }, _react.default.createElement("i", {
      className: "icomoon-save"
    }), _react.default.createElement("span", {
      className: "btn-text"
    }, "Save"))));
  }

}
/**
 * @memberof Edit
 */


// TODO: remove this hack
var _default = (0, _withNotice.default)((0, _reactRouterDom.withRouter)(Edit));

exports.default = _default;