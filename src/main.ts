import { NestFactory } from '@nestjs/core';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';
import { VersioningType, ValidationPipe } from '@nestjs/common';
import helmet from '@fastify/helmet';
import compression from '@fastify/compress';
import {
  SwaggerModule,
  DocumentBuilder,
  SwaggerDocumentOptions,
} from '@nestjs/swagger';
import { AppModule } from './app.module';

import { Logger } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter(),
  );
  app.enableCors();
  await app.register(helmet);
  await app.register(compression);

  /// global prefix add for route
  app.setGlobalPrefix('api');

  /// api versioning part
  app.enableVersioning({
    type: VersioningType.URI,
    defaultVersion: '1',
  });

  /// globally dto enabled
  app.useGlobalPipes(
    new ValidationPipe({
      exceptionFactory: (errors) => {
        const messages = errors.map(
          (error) => `${error.property} has wrong value ${error.value}`,
        );
        console.log(messages);
        return 'payload_exactly_not_match';
      },
    }),
  );

  /// swagger for api documentation
  const config = new DocumentBuilder()
    .setTitle('AJIO')
    .setDescription('The AJIO App API Documentation')
    .setVersion('1.0')
    .setBasePath('docmentation')
    .addBearerAuth()
    .build();

  const options: SwaggerDocumentOptions = {
    deepScanRoutes: true,
  };
  const document = SwaggerModule.createDocument(app, config, options);
  SwaggerModule.setup('api', app, document);

  const logger = new Logger();

  logger.debug(`Application started`);

  app.useLogger(logger);

  const port = 3000;
  app.listen(port, () => {
    logger.debug(`Server listening on port ${port}`);
  });
}
bootstrap();
