const supertest = require('supertest')
const app = require('../../app')
const request = supertest(app)

describe('GET /participants Endpoint', () => {
    it('makes a GET request to /participants', async (done) => {
        const response = await request.get('/participants')
    
        expect(response.status).toBe(200)
        done()
    })
})
