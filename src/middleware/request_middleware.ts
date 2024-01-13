// decryption.interceptor.ts

import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  Logger,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { appConstants } from 'src/config/app.config';
import { Cryptography } from 'src/interceptor/encryption';

@Injectable()
export class DecryptionInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    console.log('sssssssssssssssss');

    const request = context.switchToHttp().getRequest();
    console.log(request.body);
    if (request.method.toString() != 'GET') {
      if (!appConstants.isProduction) {
      } else {
        request.body = JSON.parse(Cryptography.decrypt(request.body.payload));
      }
    }
    Logger.debug(request.body);

    return next.handle();
  }
}
