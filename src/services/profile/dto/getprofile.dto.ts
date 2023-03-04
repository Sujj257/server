import { IsNotEmpty, IsString } from 'class-validator';

export class FetchProfileDto {
  @IsString()
  @IsNotEmpty()
  account_id: string;
}
