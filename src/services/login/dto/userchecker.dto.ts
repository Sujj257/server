import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsString, IsNotEmpty } from 'class-validator';

export class UserCheckerDto {
  @IsString()
  @ApiPropertyOptional({
    description: 'account_id',
    example: '111',
  })
  account_id: string;

}
