/*
  # Update User and Profile Access Policies
  
  1. Changes
    - Drop existing policies
    - Add new policies for admin access
    - Add new policies for user self-access
    
  2. Security
    - Maintain RLS protection
    - Add specific admin email check
    - Ensure proper user data access
*/

-- Drop existing policies
DROP POLICY IF EXISTS "users_read_access_admin" ON users;
DROP POLICY IF EXISTS "users_read_access_self" ON users;
DROP POLICY IF EXISTS "users_write_access_admin" ON users;
DROP POLICY IF EXISTS "profiles_read_access_admin" ON profiles;
DROP POLICY IF EXISTS "profiles_read_access_self" ON profiles;
DROP POLICY IF EXISTS "profiles_write_access_admin" ON profiles;

-- Create policies for users table
CREATE POLICY "users_read_access_admin_20250512"
ON users FOR SELECT
TO authenticated
USING ((auth.jwt() ->> 'email'::text) = 'uveshmalik.8860@gmail.com');

CREATE POLICY "users_read_access_self_20250512"
ON users FOR SELECT
TO authenticated
USING (auth.uid() = id);

CREATE POLICY "users_write_access_admin_20250512"
ON users FOR ALL
TO authenticated
USING ((auth.jwt() ->> 'email'::text) = 'uveshmalik.8860@gmail.com')
WITH CHECK ((auth.jwt() ->> 'email'::text) = 'uveshmalik.8860@gmail.com');

-- Create policies for profiles table
CREATE POLICY "profiles_read_access_admin_20250512"
ON profiles FOR SELECT
TO authenticated
USING ((auth.jwt() ->> 'email'::text) = 'uveshmalik.8860@gmail.com');

CREATE POLICY "profiles_read_access_self_20250512"
ON profiles FOR SELECT
TO authenticated
USING (user_id = auth.uid());

CREATE POLICY "profiles_write_access_admin_20250512"
ON profiles FOR ALL
TO authenticated
USING ((auth.jwt() ->> 'email'::text) = 'uveshmalik.8860@gmail.com')
WITH CHECK ((auth.jwt() ->> 'email'::text) = 'uveshmalik.8860@gmail.com');