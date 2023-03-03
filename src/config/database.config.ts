import { TypeOrmModuleOptions } from '@nestjs/typeorm';

export const databaseConfig : TypeOrmModuleOptions={
    type: 'postgres',
    host: 'localhost',
    port: 5432,
    username: 'postgres',
    password: 'Ctpl@123',
    logging: true, 
    database: 'live_1801',
    entities: [],
    synchronize: true,
}