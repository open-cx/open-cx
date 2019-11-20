"use strict";

var _baseRecord = _interopRequireDefault(require("../adapters/base-record"));

var _baseResource = _interopRequireDefault(require("../adapters/base-resource"));

var _propertyDecorator = _interopRequireDefault(require("../decorators/property-decorator"));

var _populator = _interopRequireDefault(require("./populator"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

describe('populator', function () {
  context('empty array given as params', function () {
    it('returns empty array when no records are given', async function () {
      const records = await (0, _populator.default)([]);
      expect(records).to.have.lengthOf(0);
    });
  });
  context('one record with one reference given', function () {
    beforeEach(function () {
      this.referenceResource = new _baseResource.default();
      this.property = new _propertyDecorator.default({});
      this.property.reference = this.sinon.stub().returns(this.referenceResource);
      this.referenceResource.populate = this.sinon.stub();
      this.record = new _baseRecord.default();
      this.record.resource = new _baseResource.default();
      this.record.resource.decorate = this.sinon.stub().returns({
        properties: [this.property]
      });
    });
    it('calls the populate record for given resource', async function () {
      await (0, _populator.default)([this.record]);
      expect(this.referenceResource.populate).to.have.been.calledOnce;
    });
    it('does not call the resource.populate() when no properties are given', async function () {
      await (0, _populator.default)([this.record], []);
      expect(this.referenceResource.populate).not.to.have.been.called;
    });
  });
});