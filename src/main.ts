import { NestFactory } from '@nestjs/core';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';
import {
  VersioningType,
  ValidationPipe,
  ValidationError,
  BadRequestException,
} from '@nestjs/common';
import helmet from '@fastify/helmet';
import compression from '@fastify/compress';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';

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
    .setTitle('carom')
    .setDescription('The carom App API Documentation')
    .setVersion('1.0')
    .addTag('API')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  await app.listen(3000);
}
bootstrap();
