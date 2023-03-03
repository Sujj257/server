import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  HttpException,
} from '@nestjs/common';
import { Observable, throwError } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { CommonResponse } from './dto/response.dto';

@Injectable()
export class ResponseInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    return next.handle().pipe(
      map((response) => {
        return {
          response,
        } as CommonResponse;
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
          () => new HttpException({ response: message }, err.status),
        );
      }),
    );
  }
}
