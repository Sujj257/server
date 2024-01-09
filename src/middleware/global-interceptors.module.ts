// global-interceptors.module.ts

import { Module, Global } from '@nestjs/common';
import { APP_INTERCEPTOR } from '@nestjs/core';
import { DecryptionInterceptor } from './request_middleware';

@Global()
@Module({
  providers: [
    {
      provide: APP_INTERCEPTOR,
      useClass: DecryptionInterceptor,
    },
    DecryptionInterceptor, // Also add this line to export the interceptor
  ],
  exports: [DecryptionInterceptor],
})
export class GlobalInterceptorsModule {}
