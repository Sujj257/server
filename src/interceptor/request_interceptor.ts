import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { JwtService } from '@nestjs/jwt';
import { SessionPayloadDto } from 'src/services/login/dto/jwttoken.dto';

@Injectable()
export class JwtInterceptor implements NestInterceptor {
  constructor(private readonly jwtService: JwtService) {}

  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const req = context.switchToHttp().getRequest();
    const token = req.headers.authorization?.split(' ')[1];
    if (token) {
      const decoded = this.jwtService.decode(token) as SessionPayloadDto;
      req.sessionpayload = decoded;
    }
    return next.handle();
  }
}
