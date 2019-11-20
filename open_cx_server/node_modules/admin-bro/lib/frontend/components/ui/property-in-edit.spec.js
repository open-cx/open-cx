"use strict";

var _react = _interopRequireDefault(require("react"));

var _reactTestingLibrary = require("react-testing-library");

var _propertyInEdit = _interopRequireDefault(require("./property-in-edit"));

var _testContextProvider = _interopRequireDefault(require("../spec/test-context-provider"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

describe('PropertyInEdit', function () {
  this.timeout(5000);
  beforeEach(function () {
    this.property = {
      name: 'name',
      label: 'someLabel'
    };
  });
  it('renders label', async function () {
    const {
      findByText
    } = (0, _reactTestingLibrary.render)(_react.default.createElement(_testContextProvider.default, null, _react.default.createElement(_propertyInEdit.default, {
      property: this.property
    })));
    const label = await findByText(this.property.label);
    expect(label).not.to.be.null;
  });
  it('renders error when it was given', async function () {
    const error = {
      message: 'some message'
    };
    const {
      findByText
    } = (0, _reactTestingLibrary.render)(_react.default.createElement(_testContextProvider.default, null, _react.default.createElement(_propertyInEdit.default, {
      property: this.property,
      error: error
    })));
    const errorObject = await findByText(error.message);
    expect(errorObject).not.to.be.null;
  });
});