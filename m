Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36CB7081A
	for <linux-integrity@vger.kernel.org>; Thu, 12 Feb 2026 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770926484; cv=none; b=SfzVf7T3hjpOgCAqDQHThouMKjGyH2gTgGHKUnLBYBEINaf8ycOy2LoGtoEH0OYkLKBo/83ao4v+rh+N9NsFoj912csCfs8dTf1KQ/4HQLJcIgHgIvXnUfAtcItSnmHmcHp9yD5TaYLKXJPzI57KNAHGK0Kz2zJUwvkKsfuht38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770926484; c=relaxed/simple;
	bh=KyMi9VG4Ea4n33jAxwvbWNQx0iHZw2OYLCV0XSEC4FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbYWvKkXKRLn9l+3xfY+uHE7Nx6dLEdLXAoF6aAbr4LtQOuc8wHdPNGaoPFp9DVgs2ZTNlNmup1phsTzIViIBGK86oNJoMGw3C775ubNrDYAIG0tJG6+DrwZEzbIAj7wvk9JoGlXa4gAPeLosB07mJZsfGou6ZGQyF8s508PLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=X5WPloUu; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="X5WPloUu"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4bc6a8021so143940a34.3
        for <linux-integrity@vger.kernel.org>; Thu, 12 Feb 2026 12:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770926482; x=1771531282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8AN6dwiMo6SD76XNciFuL1KsDP8STQGsSUlvCle818=;
        b=X5WPloUuuY3xKJvlFmJnwD6JdZnbeXRxPcqz1Kty/wajIjhvRjh8UMKYe9Ri/6PFwq
         IAtaLf1OIp9/Ia57a/y9ppkzifXQyNs8gkqx6GgBiecx2YZSQKDBuwDfygXoHEWmGI6W
         YMpJcjue607sz+dyky5zqNdJo4cE9mCM6NbQ3yuuVN0NgnABcHMtrogOFCu5h99s+mM3
         7jx5+STyjO+ohWrkg2qBy3UQyyUXk8BRYLsBQRziOH6jhSaGmccxqPIlz+VVdk22UAWc
         nkpum/KNN/8/dTy7W9rg5hXxENtQBC5N2wKxml+VQQlEmJUwBXFRi+fQITWNbP44p4Gz
         giKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770926482; x=1771531282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8AN6dwiMo6SD76XNciFuL1KsDP8STQGsSUlvCle818=;
        b=M/8KWUZiMU8ReSWA9HFmnZ5JtFvTuqEO4EQJZFhq3uzSglwPz3NDqEw9Wbkq7YPQFi
         HVBYFkW4tDTdGUOauVmfUsPOFyQ40bJabQ0maSUuvPrN7r5l8/BWUlP0UCoAxQUEDIK1
         +dKRam4Xo1PcJg+9tTVEh+CURrAQUSWNfgizQR09zzzjTajhceDhK4r++ChwDbkIh7/3
         xZSgmC8mch7rmq03o6MjPIBIMVSZHqA6PIJNapJk3Py2PHS7wTGjzIRU2I0qPEblp1Hq
         guoCaXPxUrUi6Dq3zMeauTV2ZIloYAKIyV31htWtwkvMYokgryqsLcCW1kBYoC5VasiI
         AlHw==
X-Forwarded-Encrypted: i=1; AJvYcCX8cqlrmifFW1wMUk7J/+/Tq8k1tJj5+TNXw3jRLVH8yXIlB9uC4KiFCw4dnSLzCRuX6qghs+h8MAdFujFNHg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn72po3Z0QrGRl8+wWUUW4ytkkFDnFwTqLAF4PmVgv7GPcKrwM
	GpY+sAVyc+c25PqYJwjqvxZekZF54TdEE4wlfAGH2EtsgM+pa2amnUoDOFRbY8SQPn0=
X-Gm-Gg: AZuq6aIuuIKWLJ25oTGWnBmf0OeDsio0cyIqjMQshtuqyFaCobBtrwjiMIj3kFG6sMo
	tbcMcETOgGVZTJ/s9b23G4xj/24OxuXdPkQQ0/4rKmlHV0lDVdWUaxbEKQF4CjSn00RD/TzWdxq
	sIRQK1lPs+IBEZlozXXNUqulKT/zxRn7JEcCoV4YRy6SplYD+BI6dQf8thJIkGFIjis1MLAV/X7
	VIhrvDcBlKge4MQA06AlUunrA47XTQwqCvZYOL1Es6mYyFu40Ii0yVTLwCgoRelkMhqXpY/TFHq
	8wlcewKTn9iWll2k0JVFJgn4zyN7X1UHxWlGN6Szh4oVMrefrivIqGnv3ETzu+cmBxWqC2Cu3DV
	Xkdi+YYSGIUS9QnTBFuitX75CMMdKsfqa9AQ2pMvo3V1Km9uqnHmiKlqSWy+xZWdenixRbI/Pd5
	wuc0sM
X-Received: by 2002:a05:6830:6a97:b0:7c7:18e:913a with SMTP id 46e09a7af769-7d4c31b3c88mr57247a34.19.1770926481731;
        Thu, 12 Feb 2026 12:01:21 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a76f98cesm4342584a34.22.2026.02.12.12.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 12:01:21 -0800 (PST)
Date: Thu, 12 Feb 2026 14:01:18 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v6 0/3] ima: Detect changes to files via kstat changes
 rather than i_version
Message-ID: <aY4xjh5YmZH8ujIX@CMGLRV3>
References: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
 <50c5e00a8c336e8ab393457af009c26902114688.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c5e00a8c336e8ab393457af009c26902114688.camel@linux.ibm.com>

On Thu, Feb 12, 2026 at 02:45:58PM -0500, Mimi Zohar wrote:
> On Mon, 2026-02-09 at 15:21 -0600, Frederick Lawler wrote:
> > We uncovered a case in kernels >= 6.13 where XFS is no longer updating
> > struct kstat.change_cookie on i_op getattr() access calls. Instead, XFS is
> > using multigrain ctime (as well as other file systems) for
> > change detection in commit 1cf7e834a6fb ("xfs: switch to
> > multigrain timestamps").
> > 
> > Because file systems may implement i_version as they see fit, IMA
> > unnecessarily measures files.
> 
> Statements like this are wrong and certainly unnecessary. Refer to commit
> db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version").  Directly
> accessing the i_version still worked on local filesystems.

Sorry, that's the intention I was trying to get across.

> 
> I'll be posting a patch shortly that falls back to directly reading the
> i_version, when STATX_CHANGE_COOKIE is not supported.  It cleans up the file
> change detection code, making it more readable and should simplify adding the
> ctime file change detection.
> 
> > We're proposing to compare against the kstat.change_cookie
> > directly to the cached version, and fall back to a ctime comparison,
> > if STATX_CHANGE_COOKIE is not supplied by vfs_getattr_nosec()'s result
> > mask.
> 
> Please rebase your proposed change on this patch.
>

Sounds good. I'll keep an eye out for it.

