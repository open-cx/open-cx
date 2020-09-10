const supertest = require('supertest')
const app = require('../../app')
const request = supertest(app)

describe('GET /speakers Endpoint', () => {
    it('makes a GET request to /speakers', async (done) => {
        const response = await request.get('/speakers')
    
        expect(response.status).toBe(200)
        done()
    })
})
