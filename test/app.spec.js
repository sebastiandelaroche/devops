const request = require('supertest');
const app = require('../src/config/app');

describe('app', () => {
    it('should start app', (done) => {
        request(app).get('/').expect(200, done);
    });
});
