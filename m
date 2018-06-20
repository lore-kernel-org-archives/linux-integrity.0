Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40109 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbeFTKxx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jun 2018 06:53:53 -0400
Date: Wed, 20 Jun 2018 12:53:51 +0200
From: Matthias Gerstner <mgerstner@suse.de>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: IMA: Deadlock in ima_appraise_measurement when /bin/kmod carries
 a digsig in security.evm
Message-ID: <20180620105351.GA8033@f195.suse.de>
References: <20180618145628.GD8123@f195.suse.de>
 <1529446875.3269.6.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <1529446875.3269.6.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Mimi,

> Somehow I missed it.  A more generic patch is currently queued, which
> should resolve this problem as well.  Please try commit fdc33c29b022
> ("evm: Don't deadlock if a crypto algorithm is unavailable") in the
> next-integrity-queued branch.

thank you for helping me out. I tried that patch but it does no fix the
issue completely. It still ends up in a deadlock. As you can see from
the backtrace attached below the call to public_key_verify_signature()
still causes a deadlock, since there is the following call in it:

    tfm = crypto_alloc_akcipher(alg_name, 0, 0);

Passing CRYPTO_NOLOAD here does fix the deadlock for me, but I fear that
won't be an option and the interface needs to be extended to pass flags?

Regards

Matthias

--

kgdb backtrace of deadlock situation:

#0  public_key_verify_signature (pkey=0xffff88013a8ef852, sig=0xffff88013a8ef910) at crypto/asymmetric_keys/public_key.c:100
#1  0xffffffff813b0e4a in asymmetric_verify (keyring=<optimized out>, sig=<optimized out>, siglen=<optimized out>, 
    data=0xffff88013a8ef9d4 "\334'e-\203\071m>\312@xm\242\311r2\017\212\207\230", datalen=20) at security/integrity/digsig_asymmetric.c:113
#2  0xffffffff813b0c9f in integrity_digsig_verify (id=<optimized out>, sig=<optimized out>, siglen=<optimized out>, digest=<optimized out>, 
    digestlen=<optimized out>) at security/integrity/digsig.c:75
#3  0xffffffff813b5c51 in evm_verify_hmac (dentry=0xffff88013a8ef852, xattr_name=0xffffffff8200faf5 "security.ima", 
    xattr_value=0xffff88013b14db80 "\004\004Z\361\316\062\353\001\037g\210A\260C9>\247\006\001dN`\241#\037\344\301\301\rq%\025", xattr_value_len=0, 
    iint=0x1 <irq_stack_union+1>) at security/integrity/evm/evm_main.c:178
#4  0xffffffff813b5f11 in evm_verifyxattr (dentry=<optimized out>, xattr_name=<optimized out>, xattr_value=<optimized out>, xattr_value_len=<optimized out>, 
    iint=<optimized out>) at security/integrity/evm/evm_main.c:264
#5  0xffffffff813b55b6 in ima_appraise_measurement (func=<optimized out>, iint=0xffff880138774960, file=<optimized out>, filename=<optimized out>, 
    xattr_value=0xffff88013b14db80, xattr_len=<optimized out>, opened=2) at security/integrity/ima/ima_appraise.c:243
#6  0xffffffff813b1ce3 in process_measurement (file=0xffff880137dc0300, cred=<optimized out>, secid=<optimized out>, buf=<optimized out>, 
    size=<optimized out>, mask=<optimized out>, func=FILE_CHECK, opened=<optimized out>) at security/integrity/ima/ima_main.c:301
#7  0xffffffff813b1df6 in ima_file_check (file=0xffff880137dc0300, mask=<optimized out>, opened=2) at security/integrity/ima/ima_main.c:396
#8  0xffffffff811a7675 in do_last (opened=<optimized out>, op=<optimized out>, file=<optimized out>, nd=<optimized out>) at fs/namei.c:3372
#9  path_openat (nd=0xffff88013a8efd30, op=<optimized out>, flags=<optimized out>) at fs/namei.c:3505
#10 0xffffffff811a7827 in do_filp_open (dfd=<optimized out>, pathname=<optimized out>, op=0xffff88013a8efe54) at fs/namei.c:3540
#11 0xffffffff8119ff83 in do_open_execat (fd=<optimized out>, name=0xffff88013a83b000, flags=<optimized out>) at fs/exec.c:854
#12 0xffffffff811a02b6 in do_execveat_common (fd=-100, filename=<optimized out>, flags=<optimized out>, argv=..., envp=...) at fs/exec.c:1755
#13 0xffffffff811a0788 in do_execve (filename=<optimized out>, __argv=<optimized out>, __envp=<optimized out>) at fs/exec.c:1862
#14 0xffffffff811a094b in __do_sys_execve (envp=<optimized out>, argv=<optimized out>, filename=<optimized out>) at fs/exec.c:1943
#15 __se_sys_execve (envp=<optimized out>, argv=<optimized out>, filename=<optimized out>) at fs/exec.c:1938
#16 __x64_sys_execve (regs=<optimized out>) at fs/exec.c:1938
#17 0xffffffff8100130e in do_syscall_64 (nr=<optimized out>, regs=0xffff88013a8eff58) at arch/x86/entry/common.c:287
#18 0xffffffff81a00088 in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:238
#19 0x0000000000000000 in ?? ()

(gdb) info locals

cwait = {completion = {done = 982448596, wait = {lock = {{rlock = {raw_lock = {val = {counter = 20}}}}}, head = {next = 0x200 <irq_stack_union+512>,
        prev = 0xffff880138779009}}}, err = 982448544}
tfm = <optimized out>
sig_sg = {page_link = 0, offset = 0, length = 0, dma_address = 0, dma_length = 0}
digest_sg = {page_link = 0, offset = 2172746197, length = 4294967295, dma_address = 0, dma_length = 2174749206}
alg_name = 0xffff88013a8ef840 "pkcs1pad(rsa,sha1)"
alg_name_buf = "pkcs1pad(rsa,sha1)\0<...>"


    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 849 bytes. ]
    [ Unable to print this part. ]
