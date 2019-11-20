"use strict";

var _resourceDecorator = _interopRequireDefault(require("./resource-decorator"));

var _propertyDecorator = _interopRequireDefault(require("./property-decorator"));

var _configurationError = _interopRequireDefault(require("../utils/configuration-error"));

var _adminBro = _interopRequireDefault(require("../../admin-bro"));

var _resourceStub = _interopRequireWildcard(require("../../../spec/backend/helpers/resource-stub"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

describe('ResourceDecorator', function () {
  beforeEach(function () {
    this.currentAdmin = {
      email: 'some@email.com',
      name: 'somename',
      otherValue: 'someother-value'
    };
    this.stubedRecord = this.sinon.stub();
    this.stubbedResource = (0, _resourceStub.default)(this.sinon);
    this.stubbedAdmin = this.sinon.createStubInstance(_adminBro.default);
    this.stubbedAdmin.options = {};
    this.args = {
      resource: this.stubbedResource,
      admin: this.stubbedAdmin
    };
  });
  describe('#getResourceName', function () {
    it('returns resource when name is not specified in options', function () {
      expect(new _resourceDecorator.default({ ...this.args,
        options: {}
      }).getResourceName()).to.equal(_resourceStub.expectedResult.resourceName);
    });
    it('returns resource when name is specified in options', function () {
      const name = 'newName';
      expect(new _resourceDecorator.default({ ...this.args,
        options: {
          name
        }
      }).getResourceName()).to.equal(name);
    });
  });
  describe('#getParent', function () {
    it('returns database name with its icon when no options were specified', function () {
      expect(new _resourceDecorator.default({ ...this.args,
        options: {}
      }).getParent()).to.deep.equal({
        name: _resourceStub.expectedResult.databaseName,
        icon: `icon-${_resourceStub.expectedResult.databaseType}`
      });
    });
    it('returns custom name with icon when options were specified', function () {
      const options = {
        parent: {
          name: 'somename',
          icon: 'i-icon-some'
        }
      };
      expect(new _resourceDecorator.default({ ...this.args,
        options
      }).getParent()).to.deep.equal(options.parent);
    });
  });
  describe('#decorateProperties', function () {
    beforeEach(function () {
      this.PropertyDecoratorSpy = this.sinon.spy(_propertyDecorator.default);
      this.defaultProperties = _resourceStub.expectedResult.properties;
      this.originalPropertyName = this.defaultProperties[1].name();
      this.defaultPropertyName = this.defaultProperties[0].name();
      this.defaultPropertyOptions = {
        enable: false,
        isSortable: false
      };
      this.customPropertyOptions = {
        enable: true,
        sortable: false
      };
      this.options = {
        properties: {
          [this.defaultPropertyName]: this.defaultPropertyOptions,
          newProperty: this.customPropertyOptions
        }
      };
      this.decorator = new _resourceDecorator.default({ ...this.args,
        options: this.options
      });
    });
    it('decorates all default properties - default and newProperty', function () {
      expect(Object.keys(this.decorator.properties)).to.have.lengthOf(this.defaultProperties.length + 1);
    });
    it('returns default property with options', function () {
      expect(this.decorator.properties[this.defaultPropertyName].options).to.deep.equal(this.defaultPropertyOptions);
    });
    it('returns custom property with options', function () {
      expect(this.decorator.properties.newProperty.options).to.deep.equal(this.customPropertyOptions);
    });
    it('does not pass options where there were not given', function () {
      expect(this.decorator.properties[this.originalPropertyName].options).to.deep.equal({});
    });
  });
  describe('#getProperties', function () {
    context('all properties are visible', function () {
      beforeEach(function () {
        this.sinon.stub(_propertyDecorator.default.prototype, 'isVisible').returns(true);
      });
      it('returns first n items when limit is given', function () {
        const max = 3;
        this.decorator = new _resourceDecorator.default(this.args);
        expect(this.decorator.getProperties({
          where: 'list',
          max
        })).to.have.lengthOf(max);
      });
      it('returns all properties when limit is not given', function () {
        this.decorator = new _resourceDecorator.default(this.args);
        expect(this.decorator.getProperties({
          where: 'list'
        })).to.have.lengthOf(_resourceStub.expectedResult.properties.length);
      });
      it('returns only showProperties from options if they were given', function () {
        const path = _resourceStub.expectedResult.properties[0].path();

        this.decorator = new _resourceDecorator.default({ ...this.args,
          options: {
            showProperties: [path]
          }
        });
        expect(this.decorator.getProperties({
          where: 'show'
        })).to.have.lengthOf(1);
      });
    });
  });
  describe('#resourceActions', function () {
    context('no action were specified in custom settings', function () {
      beforeEach(function () {
        const options = {};
        this.decorator = new _resourceDecorator.default({ ...this.args,
          options
        });
      });
      it('returns 2 default resource actions', function () {
        const actions = this.decorator.resourceActions(this.currentAdmin);
        expect(actions).to.have.lengthOf(2);
        const [action] = actions;
        expect(action).to.have.property('name', 'new');
      });
    });
  });
  describe('#getPropertyByKey', function () {
    beforeEach(function () {
      this.decorator = new _resourceDecorator.default({ ...this.args
      });
    });
    it('returns property by giving its key', function () {
      this.propertyPath = _resourceStub.expectedResult.properties[0].path();
      expect(this.decorator.getPropertyByKey(this.propertyPath)).to.be.an.instanceof(_propertyDecorator.default);
    });
    it('throws error when ther is no property by given key', function () {
      expect(() => {
        this.decorator.getPropertyByKey('some-unknown-name');
      }).to.throw(_configurationError.default);
    });
  });
  describe('#recordAction', function () {
    it('returns default actions', function () {
      const options = {};
      const actions = new _resourceDecorator.default({ ...this.args,
        options
      }).recordActions(this.stubedRecord, this.currentAdmin);
      expect(actions).to.have.lengthOf(3);
    });
    it('shows custom actions specified by the user', function () {
      const options = {
        actions: {
          customAction: {
            actionType: ['record']
          }
        }
      };
      const actions = new _resourceDecorator.default({ ...this.args,
        options
      }).recordActions(this.stubedRecord, this.currentAdmin);
      expect(actions).to.have.lengthOf(4);
    });
    it('hides the given action if user set isVisible to false', function () {
      const options = {
        actions: {
          show: {
            isVisible: false
          }
        }
      };
      const actions = new _resourceDecorator.default({ ...this.args,
        options
      }).recordActions(this.stubedRecord, this.currentAdmin);
      expect(actions).to.have.lengthOf(2);
    });
    it('passess properties to isVisible when it is a function', function () {
      const options = {
        actions: {
          show: {
            isVisible: data => {
              // it passess current admin to the isVisible function
              expect(data.currentAdmin).to.deep.equal(this.currentAdmin);
              expect(data.resource.id).to.equal(this.stubbedResource.id);
              expect(data.action.name).to.equal('show');
              expect(data.record).to.equal('someRecord');
              return false;
            }
          }
        }
      };
      const actions = new _resourceDecorator.default({ ...this.args,
        options
      }).recordActions('someRecord', this.currentAdmin);
      expect(actions).to.have.lengthOf(2);
    });
  });
  describe('#toJSON', function () {
    it('returns JSON representation of a resource', function () {
      const json = new _resourceDecorator.default(this.args).toJSON(this.currentAdmin);
      expect(json).to.have.keys('id', 'name', 'parent', 'href', 'titleProperty', 'resourceActions', 'listProperties', 'editProperties', 'showProperties', 'filterProperties');
    });
    it('passess current admin to the resourceActions', function () {
      const resourceActionsSpy = this.sinon.spy(_resourceDecorator.default.prototype, 'resourceActions');
      new _resourceDecorator.default(this.args).toJSON(this.currentAdmin);
      expect(resourceActionsSpy).to.have.been.calledWith(this.currentAdmin);
    });
  });
});