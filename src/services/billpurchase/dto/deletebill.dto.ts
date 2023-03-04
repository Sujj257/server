import { IsString, IsNotEmpty } from 'class-validator';

export class PurchaseDeleteDto {
  @IsString()
  @IsNotEmpty()
  bill_id: string;

  @IsString()
  @IsNotEmpty()
  ticket_id: any;
}
