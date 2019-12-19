"use strict";

var _react = _interopRequireDefault(require("react"));

var _reactTestingLibrary = require("react-testing-library");

var _factoryGirl = require("factory-girl");

var _testContextProvider = _interopRequireDefault(require("../spec/test-context-provider"));

var _noRecords = _interopRequireDefault(require("./no-records"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

require('../../../../spec/fixtures/resource.factory');

const renderComponent = resource => (0, _reactTestingLibrary.render)(_react.default.createElement(_testContextProvider.default, null, _react.default.createElement(_noRecords.default, {
  resource: resource
})));

describe('NoRecords', function () {
  this.timeout(5000);
  beforeEach(async function () {
    this.resource = await _factoryGirl.factory.build('resource');
  });
  context('resource can be created', function () {
    beforeEach(function () {
      const {
        findAllByText,
        container
      } = renderComponent(this.resource);
      this.findAllByText = findAllByText;
      this.container = container;
    });
    it('shows notification that there are no records', async function () {
      const info = await this.findAllByText('No records');
      expect(info).to.have.lengthOf(1);
    });
    it('has a link to create a new resource', function () {
      const a = this.container.querySelector('a');
      expect(a).not.to.be.null;
    });
  });
  context('resource can not be created', function () {
    beforeEach(function () {
      this.resource.resourceActions = [];
      const {
        findAllByText,
        container
      } = renderComponent(this.resource);
      this.findAllByText = findAllByText;
      this.container = container;
    });
    it('does not have a link to create a new resource', function () {
      const a = this.container.querySelector('a');
      expect(a).to.be.null;
    });
  });
});