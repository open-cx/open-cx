"use strict";

var _react = _interopRequireDefault(require("react"));

var _reactTestingLibrary = require("react-testing-library");

var _factoryGirl = require("factory-girl");

var _testContextProvider = _interopRequireDefault(require("../spec/test-context-provider"));

var _recordsTableHeader = _interopRequireDefault(require("./records-table-header"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

require('../../../../spec/fixtures/resource.factory');

describe('RecordsTableHeader', function () {
  beforeEach(async function () {
    this.property = await _factoryGirl.factory.build('property', {
      isSortable: true
    });
  });
  it('renders columns for selected properties and actions', function () {
    const {
      container
    } = (0, _reactTestingLibrary.render)(_react.default.createElement(_testContextProvider.default, null, _react.default.createElement(_recordsTableHeader.default, {
      properties: [this.property],
      titleProperty: this.property,
      sortBy: this.sortBy,
      direction: this.direction
    })));
    expect(container.getElementsByTagName('th')).to.have.lengthOf(2);
  });
});