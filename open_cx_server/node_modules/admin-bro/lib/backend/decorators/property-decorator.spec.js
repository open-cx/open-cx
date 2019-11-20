"use strict";

var _chai = require("chai");

var _propertyDecorator = _interopRequireDefault(require("./property-decorator"));

var _baseProperty = _interopRequireDefault(require("../adapters/base-property"));

var _adminBro = _interopRequireDefault(require("../../admin-bro"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

describe('PropertyDecorator', function () {
  beforeEach(function () {
    this.property = new _baseProperty.default({
      path: 'name',
      type: 'string'
    });
    this.stubbedAdmin = this.sinon.createStubInstance(_adminBro.default);
    this.stubbedAdmin.options = {};
    this.args = {
      property: this.property,
      admin: this.stubbedAdmin
    };
  });
  describe('#isSortable', function () {
    it('passes the execution to the base property', function () {
      this.sinon.stub(_baseProperty.default.prototype, 'isSortable').returns(false);
      (0, _chai.expect)(new _propertyDecorator.default(this.args).isSortable()).to.equal(false);
    });
  });
  describe('#isVisible', function () {
    it('passess execution to BaseProperty.isVisible for list when no options are specified', function () {
      (0, _chai.expect)(new _propertyDecorator.default(this.args).isVisible('list')).to.equal(this.property.isVisible());
    });
    it('passess execution to BaseProperty.isEditable for edit when no options are specified', function () {
      this.sinon.stub(_baseProperty.default.prototype, 'isVisible').returns(false);
      (0, _chai.expect)(new _propertyDecorator.default(this.args).isVisible('edit')).to.equal(this.property.isEditable());
    });
    it('sets new value when it is changed for all views by isVisible option', function () {
      const decorator = new _propertyDecorator.default({ ...this.args,
        options: {
          isVisible: false
        }
      });
      (0, _chai.expect)(decorator.isVisible('list')).to.equal(false);
      (0, _chai.expect)(decorator.isVisible('edit')).to.equal(false);
      (0, _chai.expect)(decorator.isVisible('show')).to.equal(false);
    });
  });
  const fields = ['isId', 'isTitle', 'type', 'name'];
  fields.forEach(field => {
    describe(`#${field}`, function () {
      it('passess the execution to the overrideFromOptions', function () {
        const stub = this.sinon.stub(_propertyDecorator.default.prototype, 'overrideFromOptions');
        new _propertyDecorator.default(this.args)[field](); // for some reason chai dont know that calledWith is a property

        const assertion = (0, _chai.expect)(stub).to.have.been;
        assertion.calledWith(field);
      });
    });
  });
  describe('#overrideFromOptions', function () {
    beforeEach(function () {
      this.field = 'name';
      this.value = 'valueSetByAdapter';
      this.sinon.stub(_baseProperty.default.prototype, this.field).returns(this.value);
    });
    it('passess the execution to the BaseProperty when no option is given', function () {
      const res = new _propertyDecorator.default(this.args).overrideFromOptions(this.field);
      (0, _chai.expect)(res).to.equal(this.value);
    });
    it('returns the value from options when they were specified', function () {
      this.overridenValue = 'overridenValue';
      const res = new _propertyDecorator.default({ ...this.args,
        options: {
          [this.field]: this.overridenValue
        }
      }).overrideFromOptions(this.field);
      (0, _chai.expect)(res).to.equal(this.overridenValue);
    });
    it('calls the modifier function when no options were given', function () {
      const newValue = 'someModifierFunctionValue';
      const res = new _propertyDecorator.default(this.args).overrideFromOptions(this.field, () => newValue);
      (0, _chai.expect)(res).to.equal(newValue);
    });
  });
  describe('#label', function () {
    it('returns camelcased name', function () {
      this.sinon.stub(_baseProperty.default.prototype, 'name').returns('normalname');
      (0, _chai.expect)(new _propertyDecorator.default(this.args).label()).to.equal('Normalname');
    });
  });
  describe('#availableValues', function () {
    it('map default value to { value, label } object', function () {
      this.sinon.stub(_baseProperty.default.prototype, 'availableValues').returns(['val']);
      (0, _chai.expect)(new _propertyDecorator.default(this.args).availableValues()).to.deep.equal([{
        value: 'val',
        label: 'val'
      }]);
    });
  });
  describe('#position', function () {
    it('returns -1 for title field', function () {
      this.sinon.stub(_baseProperty.default.prototype, 'isTitle').returns(true);
      (0, _chai.expect)(new _propertyDecorator.default(this.args).position()).to.equal(-1);
    });
    it('returns 100 for all other fields', function () {
      this.sinon.stub(_baseProperty.default.prototype, 'isTitle').returns(false);
      (0, _chai.expect)(new _propertyDecorator.default(this.args).position()).to.equal(100);
    });
    it('returns 0 for an id field', function () {
      this.sinon.stub(_baseProperty.default.prototype, 'isTitle').returns(false);
      this.sinon.stub(_baseProperty.default.prototype, 'isId').returns(true);
      (0, _chai.expect)(new _propertyDecorator.default(this.args).position()).to.equal(0);
    });
  });
  describe('#toJSON', function () {
    it('returns JSON representation of a property', function () {
      (0, _chai.expect)(new _propertyDecorator.default(this.args).toJSON()).to.have.keys('isTitle', 'isId', 'position', 'isSortable', 'availableValues', 'name', 'label', 'type', 'reference', 'components', 'subProperties', 'isArray');
    });
  });
});