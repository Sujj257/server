import { IsNotEmpty, IsString } from 'class-validator';

export class FetchCommissionDto {
  @IsString()
  @IsNotEmpty()
  account_id: string;
}
