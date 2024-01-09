// validation-exception.filter.ts

import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import { FastifyReply, FastifyRequest } from 'fastify';
import { appConstants } from 'src/config/app.config';
import { Cryptography } from 'src/interceptor/encryption';

@Catch(HttpException)
export class ValidationExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<FastifyReply>();
    const request = ctx.getRequest<FastifyRequest>();
    const errors = exception.getResponse() as any;

    Logger.error('errors');
    Logger.error(errors);
    if (!appConstants.isProduction) {
      response.status(HttpStatus.BAD_REQUEST).send(errors);
      return;
    }
    response
      .status(HttpStatus.BAD_REQUEST)
      .send(Cryptography.encrypt(JSON.stringify(errors)));
  }
}
