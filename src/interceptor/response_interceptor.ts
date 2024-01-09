import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import { Observable, throwError } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { CommonResponse } from './dto/response.dto';
import { Cryptography } from './encryption';
import { appConstants } from 'src/config/app.config';

@Injectable()
export class ResponseInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    return next.handle().pipe(
      map((response) => {
        var res = {
          response,
        } as CommonResponse;
        Logger.log(response.error);
        if (response.error != null) {
          return new HttpException(
            {
              data: null,
              error: response.error,
            },
            HttpStatus.BAD_REQUEST,
            {},
          );
        }
        Logger.log(res);
        if (!appConstants.isProduction) {
          return res;
        }

        return Cryptography.encrypt(JSON.stringify(res));
      }),
      catchError((err) => {
        let message: any;
        if (err instanceof HttpException) {
          message = err;
        } else if ('payload_exactly_not_match') {
          message = { data: null, error: 'payload exactly not match' };
        } else {
          message = 'An error occurred while processing your request';
        }
        return throwError(
          () =>
            new HttpException(
              {
                response: message,
              },
              HttpStatus.BAD_REQUEST,
              {},
            ),
        );
      }),
    );
  }
}
