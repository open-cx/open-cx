"use strict";

var _react = _interopRequireDefault(require("react"));

var _reactTestingLibrary = require("react-testing-library");

var _valueBlock = _interopRequireDefault(require("./value-block"));

var _testContextProvider = _interopRequireDefault(require("../spec/test-context-provider"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

describe('ValueBlock', function () {
  this.timeout(5000);
  it('renders value', async function () {
    const value = 'some value';
    const {
      findAllByText
    } = (0, _reactTestingLibrary.render)(_react.default.createElement(_testContextProvider.default, null, _react.default.createElement(_valueBlock.default, {
      value: value
    })));
    const el = await findAllByText(value);
    expect(el).to.have.lengthOf(1);
  });
});