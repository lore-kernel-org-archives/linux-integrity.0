Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66F18DF85;
	Mon,  4 Nov 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722002; cv=none; b=X/+yveCXSXQdL8lqOZASOEfBB9MIJZY3ZYph5xLteH/b+gebawsc2rCs54/UlpkuhJiEhMMdMfhDi3n1KqHtVXgrBL128ldJSgYyhAKi3RbdZ8oYtc0I+qlX4hEQvKbTV9S94XP9ZCgjmo3deNf+KM5IV9lcN6BZHQxoeLEUhIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722002; c=relaxed/simple;
	bh=4mOpJbvLbFuwYhl/LiKgeE5ZSEOT/Pwpzq4lXNPGqHY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=K+LWnQ4ljtkCqBkIC3flt128Wb1VUJb+oKRUrG11kOFG5AAxE2KxwFKee2jLj4GrtmHF3jKpdR7fsALyuDV46aYs0MTcvn7W4F+6XiILwpygSRgUQJhbl/rfphMzPnXTLYekNU+GCyAYicGZXj6hEmOXKV1EssdAvzNVc1r3HZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6ZyrXHU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6ZyrXHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705F8C4CECE;
	Mon,  4 Nov 2024 12:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730722000;
	bh=4mOpJbvLbFuwYhl/LiKgeE5ZSEOT/Pwpzq4lXNPGqHY=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=I6ZyrXHUKbpKx1Wt7JgPn5oehccwhJpCg67BH/uJg5+OyZbRMBkm4N9mtQfrfHgtr
	 LKyk8LIkOZwj8bG7VaMufAoDwnnsInFL/SNQFlegD0/qxptKi0DPunD2AAG0A9w6c2
	 5Vp/PheOoO4iIC6NLP4vZBTV9i++TPIiGnijbthusuDtdNYUVEPiIjzO8I0zZ6IUEF
	 vJrtjjkhlmfBLW08HWWzNBXmThCbVE3KL4qTU/kEajV42Ltxh3mvK9OB6KTXjiG5R5
	 asN5nIJmkhdueRYrRMi/bwK5Op1PIH7b+DqjY15/ONsmOOWBuyv7h5ylyf/EQYCWzr
	 iT14I8TUAlNmw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Nov 2024 14:06:36 +0200
Message-Id: <D5DDQSZDIAEV.AFYLTCLRYRUQ@kernel.org>
To: "Ard Biesheuvel" <ardb@kernel.org>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>
Cc: <x86@kernel.org>, "Ross Philipson" <ross.philipson@oracle.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "open list:TPM DEVICE DRIVER"
 <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, <trenchboot-devel@googlegroups.com>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
 <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
 <97d4e1a0-d86e-48a9-ad31-7e53d6885a96@apertussolutions.com>
 <CAMj1kXFEJYVs7p6QLEAU-T+xfoWhkFi=PE9QpJ4Oo4oh3eM38Q@mail.gmail.com>
In-Reply-To: <CAMj1kXFEJYVs7p6QLEAU-T+xfoWhkFi=PE9QpJ4Oo4oh3eM38Q@mail.gmail.com>

On Mon Nov 4, 2024 at 1:55 PM EET, Ard Biesheuvel wrote:
> But the inclusion of the secure launch module will force the TPM
> module to be builtin too, surely.

"config SECURE_LAUNCH" is bool =3D> no export needed.

I have it in the patches too simply  because missed it.

BR, Jarkko
