const supertest = require('supertest')
const app = require('../../app')
const request = supertest(app)

describe('GET /conferences Endpoint', () => {
    it('makes a GET request to /conferences', async (done) => {
        const response = await request.get('/conferences')
    
        expect(response.status).toBe(200)
        done()
    })
})
