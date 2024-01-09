import { TypeOrmModuleOptions } from '@nestjs/typeorm';

export const databaseConfig: TypeOrmModuleOptions = {
  type: 'postgres',
  host: 'localhost',
  port: 5432,
  username: 'postgres',
  password: 'Ctpl@123',
  logging: true,
  database: 'ajio_24-12-2023',
  entities: [],
  synchronize: true,
};
