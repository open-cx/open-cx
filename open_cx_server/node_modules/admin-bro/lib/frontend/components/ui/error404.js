"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.NoRecordError = exports.NoActionError = exports.NoResourceError = exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _ = require(".");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const Error404 = props => {
  const {
    children
  } = props;
  return _react.default.createElement(_.WrapperBox, null, _react.default.createElement(_.WrapperBox, {
    border: true
  }, _react.default.createElement("div", {
    className: "content has-text-centered"
  }, _react.default.createElement("h3", null, "404 - PAGE NOT FOUND"), _react.default.createElement("div", null, children))));
};

exports.default = Error404;

const NoResourceError = props => {
  const {
    resourceId
  } = props;
  return _react.default.createElement(Error404, null, "Resource of given id:", _react.default.createElement("b", null, ` ${resourceId} `), "cannot be found.");
};

exports.NoResourceError = NoResourceError;

const NoActionError = props => {
  const {
    resourceId,
    actionName
  } = props;
  return _react.default.createElement(Error404, null, "Resource:", _react.default.createElement("b", null, ` ${resourceId} `), "does not have an action with name:", _react.default.createElement("b", null, ` ${actionName} `));
};

exports.NoActionError = NoActionError;

const NoRecordError = props => {
  const {
    resourceId,
    recordId
  } = props;
  return _react.default.createElement(Error404, null, "Resource:", _react.default.createElement("b", null, ` ${resourceId} `), "does not have a record with id:", _react.default.createElement("b", null, ` ${recordId} `));
};

exports.NoRecordError = NoRecordError;