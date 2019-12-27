const supertest = require('supertest')
const app = require('../../app')
const request = supertest(app)

describe('GET /talks Endpoint', () => {
    it('makes a GET request to /talks', async (done) => {
        const response = await request.get('/talks')
    
        expect(response.status).toBe(200)
        done()
    })
})
