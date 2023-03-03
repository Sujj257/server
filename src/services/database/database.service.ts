import { Injectable } from '@nestjs/common';
import { EntityManager } from 'typeorm';

@Injectable()
export class DatabaseService {
  constructor(private manager: EntityManager) {}
  async executeFunc(
    query: string,
    funcName: string,
    parameters?: any[],
  ): Promise<any> {
    const response = await this.manager
      .query(query, parameters)
      .catch((reason: any) => {
        return { data: null, error: 'database function inside error' };
      });

    if (typeof response !== 'undefined' && response.length > 0) {
      const data = response[0];
      try {
        const value = JSON.stringify(data);
        const check = JSON.parse(value);
        console.log(check);
        const result = JSON.parse(check[funcName]);
        if ('error' in result) {
          if (result.error != null) {
            return { data: null, error: result.error };
          }
        }
        return { data: result.data, error: null };
      } catch (error) {
        return { data: null, error: 'json malformed error' };
      }
    } else {
      return {
        data: null,
        error: 'Database function not found or function returns nothing',
      };
    }
  }
}
